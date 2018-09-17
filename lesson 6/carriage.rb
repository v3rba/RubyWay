require_relative 'companymanagement'
require_relative 'instancecounter'

class Carriage
  
  include CompanyManagement
  include IstanceCounter

  def initialize
    register_instance
  end

  INIT_WHEELS = 8
  INIT_HEIGHT = 3
  INIT_WIDTH = 6

end
