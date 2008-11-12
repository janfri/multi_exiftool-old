module MultiExiftool

  module CommandGenerator

    @command = 'exiftool'
    @std_options = '-s -t'

    class << self

      attr_reader :std_options
      attr_accessor :command

      def options_array opts={}
        arr = []
        arr << '-n' if opts[:numerical]
        arr
      end

      def write_tag_array change_set
        arr = []
        change_set.to_hash.each do |tag, val|
          val_array = val.kind_of?(Array) ? val : [val]
          val_array.each do |v|
            arr << "-#{tag}=#{escape(v)}"
          end
        end
        arr
      end

      def read_tag_array tags
        arr = []
        tags.each do |tag|
          arr << "-#{tag}"
        end
        arr
      end

      def filenames_array filenames
        filenames.map {|fn| escape(fn) }
      end

      def read_command *args
        files, opts = parse_args(args)
        only = opts[:only]
        [command, std_options, options_array(opts), read_tag_array(only), filenames_array(files)].flatten.join(' ')
      end

      def write_command change_set, *args
        files, opts = parse_args(args)
        [command, options_array(opts), write_tag_array(change_set), filenames_array(files)].flatten.join(' ')
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
