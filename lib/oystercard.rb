class Oystercard
  LIMIT = 90
  MINIMUM = 1
  attr_reader :balance, :entry_station, :journey_history
  def initialize(balance = 0)
    @balance = balance
    @current_journey = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "Your credit cannot go over #{LIMIT}" if amount > LIMIT - @balance
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds for journey' if @balance < MINIMUM
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey.exit_station = station
    @journey_history.push @current_journey
    @current_journey = nil
    deduct(MINIMUM)
  end

  def in_journey?
    @current_journey != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
