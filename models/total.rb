require_relative('transaction')

class Total

  attr_accessor :total_value

  def initialize(total_value)
    @total_value = total_value
  end

end