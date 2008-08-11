module MultiExiftool

  module CommandGenerator

    @command = 'exiftool'
    @std_options = '-s -t'

    class << self

      attr_reader :std_options
      attr_accessor :command

      def options_string opts={}
        result = []
        opts.each_key do |opt|
          case opt
          when :numerical
            result << '-n'
          end
        end
        result.join(' ')
      end

      def write_tag_string write_object
        opts = []
        write_object.each do |tag, val|
          opts << %Q(-#{tag}="#{val}")
        end
        opts.join(' ')
      end

      def read_command_string *files
        "#{command} #{std_options} #{options_string} #{files.join(' ')}"
      end

      def write_command_string write_object, *files
        "#{command} #{options_string} #{write_tag_string(write_object)} #{files.join(' ')}"
      end

    end

  end

end
