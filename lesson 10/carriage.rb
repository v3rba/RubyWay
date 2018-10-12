require './manufacturer'
require './instances'
require './carriage_overflowed_error'
require './validation_error'
require './validation'

class Carriage
  include Manufacturer
  include Instances
  include Validation

  attr_reader :capacity, :filled_capacity
  validate :capacity, :positive

  def initialize(capacity)
    @capacity = capacity
    @filled_capacity = 0
    validate!
    add(self)
  end

  def fill(capacity)
    validate_free!(capacity)
    self.filled_capacity += capacity
  end

  def free_space
    capacity - filled_capacity
  end

  protected

  attr_writer :filled_capacity

  def validate_free!(capacity)
    raise CarriageOverflowedError, 'Carriage has been overflowed' if free_space < capacity

    true
  end
end
