module MultiExiftool

  module Helper

    def arrify val
      if val.respond_to? :to_ary
        return val.to_ary
      elsif val != nil
        return [val]
      else
        return []
      end
    end

  end

end
