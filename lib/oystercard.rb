require 'journey'

class Oystercard
  BALANCE_LIMIT = 90
  TRAVEL_BALANCE = 1

  attr_reader :balance, :entry_station, :journey, :history

  def initialize
    @balance = 0
    @history = []
    @journey = nil
  end

  def top_up! amount
    total = balance + amount
    fail "Cannot exceed balance of #{BALANCE_LIMIT}!" if over_limit? total
    @balance = total
  end

  def touch_in! station
    fail "Top up needed!" if under_limit?
    @journey = Journey.new(station)
  end

  def touch_out! station
    @journey = Journey.new(nil) if journey == nil
    journey.exit_station = station
    history << journey
    deduct!(journey.fare)
    @journey = nil
  end

  def in_journey?
    !!journey
  end

  private

  def deduct! amount
    @balance -= amount
  end

  def over_limit? total
    total > BALANCE_LIMIT
  end

  def under_limit?
    balance < TRAVEL_BALANCE
  end
end
