# frozen_string_literal: true

# this class models the log, acts as intermediary between oystercard and journey.
class JourneyLog
  attr_reader :current_journey
  def initialize(journey_class: Journey.new)
    @current_journey = journey_class
    @history = []
    # @current_journey = Journey.new
  end

  def start(entry_station)
    @history << @current_journey unless @current_journey.entry_station.nil?
    @current_journey = Journey.new(entry_station: entry_station)
  end

  def finish(exit_station)
    @history << @current_journey.finish(exit_station)
    @current_journey = Journey.new
  end

  def history
    @history.clone
  end

  # private

  # def current_journey
  #   @current_journey.complete? ? @current_journey = Journey.new : @current_journey
  # end
end
