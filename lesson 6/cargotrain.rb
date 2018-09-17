class CargoTrain < Train

  def add_carriages(carriage)
    super if carriage.class == CargoCarriage
  end

end
