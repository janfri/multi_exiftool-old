require 'multi_exiftool/method_access'

module MultiExiftool

  class WriteObject

    include MethodAccess

    def each &block
      @values.each &block
    end

  end


end
