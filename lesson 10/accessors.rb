module Accessors

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        define_methods(name)
    end
  end

  def strong_attr_accessor(name, type)
      sym_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get sym_name }
      define_method("#{name}=") do |value|
        raise "Type should be #{type}" unless type == value.class
        instance_variable_set sym_name, value
      end
  end
end
