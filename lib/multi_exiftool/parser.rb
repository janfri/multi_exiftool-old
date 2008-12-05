module MultiExiftool

  class Parser

    # :stopdoc:
    REGEXP_TAGLINE = /^(\w+)\t(.*)$/.freeze
    REGEXP_STRIPLINE = /^={8} /.freeze
    # :startdoc:

    attr_reader :result, :errors

    def parse_reading stdout, stderr
      @result = []
      @errors = []
      image_info = {}
      while !stdout.eof
        line = stdout.readline.chomp
        case line
        when REGEXP_TAGLINE 
          image_info[$1] = $2
        when REGEXP_STRIPLINE
          unless image_info.empty?
            @result << image_info
          end
          image_info = {}
        end
      end
      unless image_info.empty?
        @result << image_info
      end
      while !stderr.eof
        @errors << stderr.readline.chomp
      end
      true
    end

  end

end
