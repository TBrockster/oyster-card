# frozen_string_literal: true
require_relative 'journey'
require_relative 'station'

# this class simulates oystercards
class Oystercard
  attr_reader :balance
  # attr_reader :entry_station
  attr_accessor :journeys
  DEFAULT_MAXIMUM = 90
  MININMUM_TOUCH_IN = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
    # @journey = Hash.new
    # @in_journey = false
  end

  def top_up(amount)
    raise "error: top-up exceeds maximum (#{DEFAULT_MAXIMUM})" if max?(amount)

    @balance += amount
  end

  def touch_in(entry_station) 
    raise 'error: insufficient funds' if min?

    deduct(@journey.fare) if @journey.entry_station != nil
    @journey = Journey.new(entry_station: entry_station)
    # @in_journey = true
    # @entry_station = entry_station
  end

  def touch_out(exit_station)
    # raise 'error: Not in journey' unless in_journey?

    # @in_journey = false
    
    @journey.finish(exit_station)
    deduct(@journey.fare)
    @journeys << @journey
    @journey = Journey.new
    # @entry_station = nil
  end

  private

  # def in_journey?
  #   @journey[:Entry] != nil
  # end

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
