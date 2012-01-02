require 'fileutils'
require 'erb'

class Template

  def initialize(cygwin_home, templates_dir)
    @cygwin_home = cygwin_home
    @templates_dir = templates_dir
  end

  def copy(filename)
    source_file = File.join(@templates_dir, filename)
    target_file = File.join(@cygwin_home, filename)

    template = IO.binread(source_file)
    # FIXME: using original content makes the operation non-idempotent
    #@original_content = File.exist?(target_file) && IO.binread(target_file)
    content = ERB.new(template).result(binding)
    if dos_newlines?(template)
      content = dos_to_unix_newlines(content)
    end

    FileUtils.mkdir_p(File.dirname(target_file))
    File.open(target_file, 'wb') do |file|
      file.write(content)
    end
  end

  def dos_newlines?(text)
    text.include?("\r\n")
  end

  def dos_to_unix_newlines(text)
    text.sub("\n", "\r\n")
  end
end
