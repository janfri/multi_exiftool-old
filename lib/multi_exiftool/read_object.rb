module MultiExiftool

  class ReadObject

    def initialize values={}
      @values = {}
      values.each do |tag, val|
        @values[unify(tag)] = val
      end
      @values.freeze
    end

    def each &block
      @values.each &block
    end

    def [] tag
      @values[unify(tag)]
    end

    private

    def unify tag
      tag.gsub(/[\-_]/, '').downcase
    end

    def method_missing sym, *args
      name = unify(sym.id2name)
      @values[name]
    end

  end

end
