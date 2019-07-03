# frozen_string_literal: true

require_relative 'journey'
require_relative 'station'

# this class simulates oystercards
class Oystercard
  attr_reader :balance
  attr_accessor :journeys
  DEFAULT_MAXIMUM = 90
  MININMUM_TOUCH_IN = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journeys = []
    @journey = journey
  end

  def top_up(amount)
    raise "error: top-up exceeds maximum (#{DEFAULT_MAXIMUM})" if max?(amount)

    @balance += amount
  end

  def touch_in(entry_station)
    raise 'error: insufficient funds' if min?

    deduct(@journey.fare) if @journey.begun?
    @journey = Journey.new(entry_station: entry_station)
  end

  def touch_out(exit_station)
    raise 'error: insufficient funds to pay fee' if !@journey.begun? && balance < Journey::PENALTY_FARE

    @journey.finish(exit_station)
    deduct(@journey.fare)
    end_journey
  end

  private

  def end_journey
    @journeys << @journey
    @journey = Journey.new
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
