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
        arr = []
        change_set.to_hash.each do |tag, val|
          val_array = val.kind_of?(Array) ? val : [val]
          val_array.each do |v|
            arr << "-#{tag}=#{escape(v)}"
          end
        end
        arr.join(' ')
      end

      def read_tag_string tags
        arr = []
        tags.each do |tag|
          arr << "-#{tag}"
        end
        arr.join(' ')
      end

      def filenames_string filenames
        filenames.map {|fn| escape(fn) }.join(' ')
      end

      def read_command_string *args
        files, opts = parse_args(args)
        "#{command} #{std_options} #{options_string(opts)} #{filenames_string(files)}"
      end

      def write_command_string change_set, *args
        files, opts = parse_args(args)
        "#{command} #{options_string(opts)} #{write_tag_string(change_set)} #{filenames_string(files)}"
      end

      def parse_args(args)
        opts = args.last.kind_of?(Hash) ? args.pop : {}
        [args, opts]
      end

      def escape string
        return string unless string =~ /[ \\]/
          '"' << string.gsub("\\") { "\\\\" } << '"'
      end

    end

  end

end
