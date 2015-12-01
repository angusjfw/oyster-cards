class Oystercard
  BALANCE_LIMIT = 90
  TRAVEL_BALANCE = 1
  FARE = 2
  attr_reader :balance, :entry_station, :journey, :history

  def initialize
    @balance = 0
    @journey = { entry_station: nil, exit_station: nil }
    @history = []
  end

  def top_up! amount
    total = balance + amount
    fail "Cannot exceed balance of #{BALANCE_LIMIT}!" if over_limit? total
    @balance = total
  end

  def touch_in! station
    fail "Top up needed!" if under_limit?
    journey[:entry_station] = station
  end

  def touch_out! station
    journey[:exit_station] = station
    history << journey
    @journey = { entry_station: nil, exit_station: nil }
    deduct!(FARE)
  end

  def over_limit? total
    total > BALANCE_LIMIT
  end

  def under_limit?
    balance < TRAVEL_BALANCE
  end

  def in_journey?
    !!journey[:entry_station]
  end

  private

  def deduct! amount
    @balance -= amount
  end
end
