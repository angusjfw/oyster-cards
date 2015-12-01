class Oystercard
  BALANCE_LIMIT = 90
  attr_reader :balance, :in_use
  alias_method :in_journey?, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up! amount
    total = balance + amount
    fail "Cannot exceed balance of #{BALANCE_LIMIT}!" if over_limit? total
    @balance = total
  end

  def deduct! amount
    @balance -= amount
  end

  def over_limit? total
    total > BALANCE_LIMIT
  end

  def touch_in!
    @in_use = true
  end

  def touch_out!
    @in_use = false
  end
end
