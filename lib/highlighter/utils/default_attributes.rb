module Highlighter
  module Utils
    module DefaultAttributes
      def accessor_with_default(name, default=nil)
        ivar = "@#{name}"
        define_method(name) do
          instance_variable_defined?(ivar) ? instance_variable_get(ivar) : default
        end
        define_method("#{name}=") do |value|
          instance_variable_set(ivar, value)
        end
      end
    end
  end
end