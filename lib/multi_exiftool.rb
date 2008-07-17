require 'multi_exiftool/command_generator'
require 'multi_exiftool/parser'
require 'multi_exiftool/read_object'
require 'multi_exiftool/write_object'
require 'open3'

module MultiExiftool

  def self.read *filenames
    cmd = CommandGenerator.read_command_string *filenames
    stdin, stdout, stderr = Open3.popen3(cmd)
    result = Parser.parse(stdout, stderr)
    result.map {|r| ReadObject.new(r.data)}
  end


  def self.write write_object, *filenames
  end

end
