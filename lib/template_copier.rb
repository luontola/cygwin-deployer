# Copyright © 2012 Esko Luontola <www.orfjackal.net>
# This software is released under the Apache License 2.0.
# The license text is at http://www.apache.org/licenses/LICENSE-2.0

require 'fileutils'
require 'pathname'
require 'erb'

class TemplateCopier

  def initialize(options)
    @cygwin_home = options[:cygwin_home]
    @user_home = options[:user_home]
    @username = options[:username]
    @templates_dir = options[:templates_dir]
  end

  def copy_all
    profile_skeleton = File.join(@cygwin_home, 'etc/skel')
    all_files_in(profile_skeleton).each { |file| copy_to_user_home(file) }

    all_files_in(@templates_dir).each { |file| process_template(file) }

    cygwin_symlink(@user_home, File.join(@cygwin_home, 'home', @username))
  end

  private

  def all_files_in(dir)
    Dir.glob(File.join(dir, '**/*'), File::FNM_DOTMATCH).reject { |file_or_dir| Dir.exist?(file_or_dir) }
  end

  def copy_to_user_home(file)
    # If the directory doesn't exist, 'cp' would create a file with the same name,
    # so let's make sure the directory exists first. This happens usually only during testing.
    unless Dir.exist?(@user_home)
      puts "\nCreating home directory: #{@user_home}"
      FileUtils.mkdir_p(@user_home)
      run('icacls', @user_home, '/setowner', @username)
      run('icacls', @user_home, '/grant', @username+':(OI)(CI)F')
    end

    FileUtils.cp(file, @user_home)
  end

  def process_template(template_file)
    puts "\nProcessing template: #{template_file}"
    relative_path = Pathname.new(template_file).relative_path_from(Pathname.new(@templates_dir))

    if relative_path.each_filename.first == 'home'
      target_file = File.join(@user_home, relative_path.relative_path_from(Pathname.new('home')))
    else
      target_file = File.join(@cygwin_home, relative_path)
    end

    template = IO.binread(template_file)
    content = ERB.new(template).result(binding)
    write(target_file, content)
  end

  def write(file, content)
    puts "Writing: #{file}"
    create_parent_dirs(file)
    File.open(file, 'wb') { |f| f.write(content) }
  end

  def cygwin_symlink(target, link_name)
    bytes = []
    bytes += "!<symlink>".encode('US-ASCII').bytes.to_a
    bytes += [255, 254] # BOM
    bytes += target.encode('UTF-16LE').bytes.to_a
    bytes += [0, 0] # string terminator

    create_parent_dirs(link_name)
    File.open(link_name, 'wb') { |file|
      bytes.each { |byte| file.putc(byte) }
    }

    run('attrib', '-A', '+S', link_name)
  end

  def create_parent_dirs(file)
    FileUtils.mkdir_p(File.dirname(file))
  end

  # methods usable in templates

  def include(file)
    file = File.join(@cygwin_home, file)
    puts "Including: #{file}"
    IO.binread(file)
  end

  def escape_backslashes(path)
    # Concerning the number of backslashes:
    # http://stackoverflow.com/questions/1542214/weird-backslash-substitution-in-ruby
    path.gsub('\\') { '\\\\' }
  end
end
