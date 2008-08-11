module MultiExiftool

  module CommandGenerator

    @command = 'exiftool'
    @std_options = '-s -t'

    class << self

      attr_reader :std_options
      attr_accessor :command

      def options_string opts={}
        result = []
        result << '-n' if opts[:numerical]
        result.join(' ')
      end

      def write_tag_string write_object
        opts = []
        write_object.each do |tag, val|
          opts << %Q(-#{tag}="#{val}")
        end
        opts.join(' ')
      end

      def read_command_string *args
        files, opts = parse_args(args)
        "#{command} #{std_options} #{options_string(opts)} #{files.join(' ')}"
      end

      def write_command_string write_object, *args
        "#{command} #{options_string(opts)} #{write_tag_string(write_object)} #{files.join(' ')}"
      end

      def parse_args(args)
        opts = args.last.kind_of?(Hash) ? args.pop : {}
        [args, opts]
      end

    end

  end

end
