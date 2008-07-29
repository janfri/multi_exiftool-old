module MultiExiftool

  module MethodAccess

    def initialize values={}
      @values = {}
      values.each do |tag, val|
        @values[unify(tag)] = val
      end
    end

    def each &block
      @values.each &block
    end

    def [] tag
      @values[unify(tag)]
    end

    def []= tag, val
      @values[unify(tag)] = val
    end

    def unify tag
      tag.gsub(/[\-_]/, '').downcase
    end

    private

    def method_missing sym, *args
      name = unify(sym.id2name)
      if name.sub!(/=$/, '')
        @values[name] = args.first
      else
        @values[name]
      end
    end

  end

end
