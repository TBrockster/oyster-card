# frozen_string_literal: true

# this class simulates the stations
class Station
  attr_reader :name, :zone
  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end
