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

      def write_tag_string change_set
        opts = []
        change_set.to_hash.each do |tag, val|
          val_array = val.kind_of?(Array) ? val : [val]
          val_array.each do |v|
            opts << %Q(-#{tag}="#{v}")
          end
        end
        opts.join(' ')
      end

      def read_command_string *args
        files, opts = parse_args(args)
        "#{command} #{std_options} #{options_string(opts)} #{files.join(' ')}"
      end

      def write_command_string change_set, *args
        files, opts = parse_args(args)
        "#{command} #{options_string(opts)} #{write_tag_string(change_set)} #{files.join(' ')}"
      end

      def parse_args(args)
        opts = args.last.kind_of?(Hash) ? args.pop : {}
        [args, opts]
      end

    end

  end

end
