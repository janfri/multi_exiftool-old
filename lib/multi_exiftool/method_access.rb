module MultiExiftool

  module MethodAccess

    def initialize values={}
      @values = values
    end

    def each &block
      @values.each &block
    end

    def [] tag
      @values[tag]
    end

    def []= tag, val
      @values[tag] = val
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
