# frozen_string_literal: true

# this class models the journey
class Journey
  attr_reader :entry_station
  attr_reader :exit_station
  PENALTY_FARE = 6
  REGULAR_FARE = 1
  def initialize(entry_station: nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

  def fare
    complete? ? REGULAR_FARE : PENALTY_FARE
  end

  def finish(station)
    @exit_station = station
    self
  end
end
