require 'multi_exiftool/command_generator'
require 'multi_exiftool/parser'
require 'multi_exiftool/read_object'
require 'open3'
require 'ostruct'

# monkey patching --- the save way :D
class OpenStruct
  unless self.new.respond_to? :to_hash
    def to_hash
      @table
    end
  end
end

module MultiExiftool

  class << self

    def read *filenames
      cmd = CommandGenerator.read_command *filenames
      stdin, stdout, stderr = Open3.popen3(cmd)
      result = Parser.parse(stdout, stderr)
      result.map {|r| ReadObject.new(r.data)}
    end


    def write change_set, *filenames
      cmd = CommandGenerator.write_command change_set, *filenames
      stdin, stdout, stderr = Open3.popen3(cmd)
      result = Parser.parse(stdout, stderr)
      result.inject(true) {|r| r.errors.empty?}
    end

  end

end
