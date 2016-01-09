module Highlighter
  module Utils
    class DefaultAttributes
      class << self
        def attributes
          @attributes ||= {}
        end

        def accessor_with_default(name, default=nil)
          send(:attr_accessor, name)
          attributes[name.to_sym] = default
        end
      end

      def initialize
        self.class.attributes.each do |at, value|
          send("#{at}=", value)
        end
      end
    end
  end
end