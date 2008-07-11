module MultiExiftool

  module CommandGenerator

    class << self

      def write_tag_string write_object
        opts = []
        write_object.each do |tag, val|
          opts << %Q(-#{tag}="#{val}")
        end
        opts.join(' ')
      end

    end

  end

end
