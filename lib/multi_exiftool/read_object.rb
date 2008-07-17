require 'multi_exiftool/method_access'

module MultiExiftool

  class ReadObject

    include MethodAccess

    def initialize values
      super(values)
      @values.freeze
    end

  end

end
