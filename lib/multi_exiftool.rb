require 'multi_exiftool/command_generator'
require 'multi_exiftool/parser'
require 'multi_exiftool/read_object'
require 'open3'
require 'ostruct'

# Monkey patching :D
class OpenStruct
  def to_hash
    @table
  end
end

module MultiExiftool

  def self.read *filenames
    cmd = CommandGenerator.read_command_string *filenames
    stdin, stdout, stderr = Open3.popen3(cmd)
    result = Parser.parse(stdout, stderr)
    result.map {|r| ReadObject.new(r.data)}
  end


  def self.write change_set, *filenames
    cmd = CommandGenerator.write_command_string change_set, *filenames
    stdin, stdout, stderr = Open3.popen3(cmd)
    result = Parser.parse(stdout, stderr)
    result.inject(true) {|r| r.errors.empty?}
  end

end
