module MultiExiftool

  module CommandGenerator

    @command = 'exiftool'
    @std_options = '-s -t'

    class << self

      attr_reader :std_options
      attr_accessor :command

      def write_tag_string write_object
        opts = []
        write_object.each do |tag, val|
          opts << %Q(-#{tag}="#{val}")
        end
        opts.join(' ')
      end

      def read_command_string *files
        "#{command} #{std_options} #{files.join(' ')}"
      end

      def write_command_string write_object, *files
        "#{command} #{std_options} #{write_tag_string(write_object)} #{files.join(' ')}"
      end

    end

  end

end
