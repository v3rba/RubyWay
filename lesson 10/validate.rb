module Validation

  module ClassMethods
    def validate(field, method, *params)
      define_method("validate_#{field}_#{method}") do
        send(method.to_sym, instance_variable_get("@#{field}".to_sym), *params)
    end
  end
end

module InstanceMethods
    def validate!
      public_methods.each { |method| send(method) if method =~ /^validate_/ }
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    def presence(value)
      unless value.nil? || value == ''
        raise ValidationError, "Value can't be blank"
      end
      true
    end

    def format(value, reg_exp)
      raise ValidationError, 'Wrong value' unless value =~ reg_exp
      true
    end

end
