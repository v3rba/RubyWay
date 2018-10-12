module Accessors
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        define_methods(name)
    end
  end
end
