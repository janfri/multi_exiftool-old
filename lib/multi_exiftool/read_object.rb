module MultiExiftool

  class ReadObject

    include MultiExiftool::Helper

    def initialize values={}
      @values = {}
      values.each do |tag, val|
        @values[unify(tag)] = val
      end
      @values.freeze
    end

    def each
      @values.each do |tag, val|
        yield tag, convert(val)
      end
    end

    def [] tag
      convert(@values[unify(tag)])
    end

    def path
      dir = self.directory
      filename = self.filename
      raise Error.new('No path found.') if dir.nil? || filename.nil?
      File.join(dir, filename)
    end

    class << self
      attr_accessor :converting_rules
    end

    private

    def convert val
      result = val
      ReadObject.converting_rules.each do |test, proc|
        if test === val
          result = proc.call(val)
          break
        end
      end
      result
    end

    def method_missing sym, *args
      name = unify(sym.id2name)
      self[name]
    end

    @converting_rules = []

    @converting_rules << [/^0+\d+$/, lambda {|val| val}]
    @converting_rules << [/^[+\-]?\d+$/, lambda {|val| val.to_i}]
    @converting_rules << [/^[+\-]?\d+\.\d+$/, lambda {|val| val.to_f}]

  end

end
