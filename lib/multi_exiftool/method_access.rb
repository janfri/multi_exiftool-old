module MultiExiftool

  module MethodAccess

    def initialize
      @values = {}
    end

    private

    def method_missing sym, *args
      name = sym.id2name
      if name.sub!(/=$/, '')
        @values[name] = args.first
      else
        @values[name]
      end
    end

  end

end
