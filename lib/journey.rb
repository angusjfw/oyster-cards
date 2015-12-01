class Journey
  attr_reader :entry
  attr_accessor :exit_station

  FARE = 2
  PENALTY_FARE = 6

  def initialize station
    @entry = station
    @exit_station = nil
  end

  def fare
    return PENALTY_FARE unless entry && exit_station
    FARE
  end
end
