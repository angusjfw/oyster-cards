class Oystercard
  BALANCE_LIMIT = 90
  TRAVEL_BALANCE = 1
  FARE = 2
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up! amount
    total = balance + amount
    fail "Cannot exceed balance of #{BALANCE_LIMIT}!" if over_limit? total
    @balance = total
  end

  def touch_in! station
    fail "Top up needed!" if under_limit?
    @entry_station = station
  end

  def touch_out!
    @entry_station = nil
    deduct!(FARE)
  end

  def over_limit? total
    total > BALANCE_LIMIT
  end

  def under_limit?
    balance < TRAVEL_BALANCE
  end

  def in_journey?
    !!entry_station
  end
  private

  def deduct! amount
    @balance -= amount
  end
end
