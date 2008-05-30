module MultiExiftool

  module Parser

    # :stopdoc:
    REGEXP_TAGLINE = /^(\w+)\t(.*)$/.freeze
    REGEXP_STRIPLINE = /^={8} /.freeze
    # :startdoc:

    def self.parse stdout, stderr
      result = []
      image_info = {}
      while !stdout.eof
        line = stdout.readline.chomp
        case line
        when REGEXP_TAGLINE 
          image_info[$1] = $2
        when REGEXP_STRIPLINE
          unless image_info.empty?
            result << Result.new(image_info, {})
          end
          image_info = {}
        end
      end
      unless image_info.empty?
        result << Result.new(image_info, {})
      end
      result
    end

    class Result

      attr_reader :data, :errors

      def initialize data, errors
        @data, @errors = data.freeze, errors.freeze
      end

    end

  end

end
