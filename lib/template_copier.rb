require 'fileutils'
require 'pathname'
require 'erb'

class TemplateCopier

  def initialize(options)
    @cygwin_home = options[:cygwin_home]
    @user_home = options[:user_home]
    @templates_dir = options[:templates_dir]
  end

  def copy_all
    profile_skeleton = File.join(@cygwin_home, 'etc/skel')
    all_files_in(profile_skeleton).each { |file| copy_to_user_home(file) }

    all_files_in(@templates_dir).each { |file| process_template(file) }
  end

  private

  def all_files_in(dir)
    Dir.glob(File.join(dir, '**/*'), File::FNM_DOTMATCH).reject { |file_or_dir| Dir.exist?(file_or_dir) }
  end

  def copy_to_user_home(file)
    # If the directory doesn't exist, 'cp' would create a file with the same name,
    # so let's make sure the directory exists first.
    # TODO: the directory will be owned by Administrators - change it? (though this happens only when testing)
    FileUtils.mkdir_p(@user_home)

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
    FileUtils.mkdir_p(File.dirname(file))
    File.open(file, 'wb') { |f| f.write(content) }
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
