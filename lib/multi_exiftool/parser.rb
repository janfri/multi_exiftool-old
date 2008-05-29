module MultiExiftool

  module Parser

    REGEXP_TAGLINE = /^(\w+)\t(.*)$/.freeze
    REGEXP_STRIPLINE = /^={8} /


    def self.parse stdout, stderr
      result = []
      image_info = {}
      while !stdout.eof
        line = stdout.readline.chomp
        case line
        when REGEXP_TAGLINE 
          image_info[$1] = $2
        when REGEXP_STRIPLINE
          result << image_info unless image_info.empty?
          image_info.clear
        end
      end
      result << image_info unless image_info.empty?
      result
    end

    class Result

      attr_reader :data, :errors

      def initialize data, errors
        @data, @errors = data, errors
      end

    end

  end

end
