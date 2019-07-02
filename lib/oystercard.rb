# frozen_string_literal: true

# this class simulates oystercards
class Oystercard
  attr_reader :balance
  # attr_reader :entry_station
  attr_reader :journeys
  DEFAULT_MAXIMUM = 90
  MININMUM_TOUCH_IN = 1

  def initialize
    @balance = 0
    @journeys = Hash.new
    # @in_journey = false
  end

  def top_up(amount)
    raise "error: top-up exceeds maximum (#{DEFAULT_MAXIMUM})" if max?(amount)

    @balance += amount
  end

  def touch_in(entry_station)
    raise 'error: Already in journey' if in_journey?
    raise 'error: insufficient funds' if min?

    # @in_journey = true
    @journeys[:Entry] = entry_station
    # @entry_station = entry_station
  end

  def touch_out(exit_station)
    raise 'error: Not in journey' unless in_journey?

    # @in_journey = false
    deduct(MININMUM_TOUCH_IN)
    @journeys[:Exit] = exit_station
    # @entry_station = nil
  end

  private

  def in_journey?
    @journeys[:Entry] != nil
  end

  def deduct(amount)
    raise 'error: insufficient funds' if enough?(amount)

    @balance -= amount
  end

  def max?(amount)
    @balance + amount > DEFAULT_MAXIMUM
  end

  def enough?(amount)
    amount > @balance
  end

  def min?
    @balance < MININMUM_TOUCH_IN
  end
end
