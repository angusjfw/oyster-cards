class Oystercard
  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up! amount
    total = balance + amount
    fail "Cannot exceed balance of #{BALANCE_LIMIT}!" if over_limit? total
    @balance = total  
  end

  def over_limit? total
    total > BALANCE_LIMIT
  end
end
