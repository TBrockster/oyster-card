# frozen_string_literal: true

# this class simulates oystercards
class Oystercard
  attr_reader :balance
  DEFAULT_MAXIMUM = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "error: top-up exceeds maximum (#{DEFAULT_MAXIMUM})" if max?(amount)
    @balance += amount
  end

private

def max?(amount)
@balance + amount > DEFAULT_MAXIMUM
end
end
