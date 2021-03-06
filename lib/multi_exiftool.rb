require 'multi_exiftool/helper'
require 'multi_exiftool/command_generator'
require 'multi_exiftool/parser'
require 'multi_exiftool/read_object'
require 'open3'
require 'ostruct'
require 'logger'

# monkey patching --- the save way :D
class OpenStruct
  unless self.new.respond_to? :to_hash
    def to_hash
      @table
    end
  end
end

module MultiExiftool

  class Error < Exception; end

  class << self

    attr_accessor :logger

    def read *filenames
      cmd = CommandGenerator.read_command *filenames
      stdin, stdout, stderr = Open3.popen3(cmd)
      result = Parser.new.parse_reading(stdout, stderr).result
      result.map {|r| ReadObject.new(r.data)}
    end


    def write change_set, *filenames
      cmd = CommandGenerator.write_command change_set, *filenames
      @logger.debug cmd
      stdin, stdout, stderr = Open3.popen3(cmd)
      result = Parser.new.parse_writing(stdout, stderr).result
      result.inject(true) {|r| r.errors.empty?}
    end

  end
  
  @logger = Logger.new nil

end
