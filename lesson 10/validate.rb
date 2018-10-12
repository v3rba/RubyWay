module Validation

  module ClassMethods
    def validate(field, method, *params)
      define_method("validate_#{field}_#{method}") do
        send(method.to_sym, instance_variable_get("@#{field}".to_sym), *params)
    end
  end
end
