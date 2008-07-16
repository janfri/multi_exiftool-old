module MultiExiftool

  module MethodAccess

    def initialize values={}
      @values = values
    end

    def each &block
      @values.each &block
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
