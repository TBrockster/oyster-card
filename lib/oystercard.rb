# frozen_string_literal: true

require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

# this class simulates oystercards
class Oystercard
  attr_reader :balance
  DEFAULT_MAXIMUM = 90
  MININMUM_TOUCH_IN = Journey::REGULAR_FARE
  PENALTY_FARE = Journey::PENALTY_FARE

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    raise "error: top-up exceeds maximum (#{DEFAULT_MAXIMUM})" if max?(amount)

    @balance += amount
  end

  def touch_in(entry_station)
    raise 'error: insufficient funds' if min?

    deduct(PENALTY_FARE) if @journey_log.current_journey.begun?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    raise 'error: insufficient funds to pay fee' if fee_too_high?

    @journey_log.finish(exit_station)
    deduct(@journey_log.history[-1].fare)
  end

  def print_history
    @journey_log.history
  end

  private

  def fee_too_high?
    !@journey_log.current_journey.begun? && balance < PENALTY_FARE
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
