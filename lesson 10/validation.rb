require './validation_error'

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
    rescue StandardError
      false
    end

    protected

    def presence(value)
      raise ValidationError, "Value can't be blank" unless value.nil? || value == ''

      true
    end

    def format(value, reg_exp)
      raise ValidationError, 'Wrong value' unless value =~ reg_exp

      true
    end

    def type(value, type_class)
      raise ValidationError, 'Wrong type' unless value.class == type_class

      true
    end

    def positive(value)
      raise ValidationError, 'Negative value' if value < 0

      true
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
