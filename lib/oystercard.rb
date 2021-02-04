class Oystercard
  LIMIT = 90
  MINIMUM = 1
  attr_reader :balance, :entry_station, :journey_history
  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "Your credit cannot go over #{LIMIT}" if amount > LIMIT - @balance
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds for journey' if @balance < MINIMUM
    @entry_station = station
  end

  def touch_out(station)
    @journey_history.push({in: @entry_station, out: station})
    @entry_station = nil
    deduct(MINIMUM)
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end


