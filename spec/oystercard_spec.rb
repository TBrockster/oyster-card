# frozen_string_literal: true

require 'Oystercard'

describe Oystercard do
  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'new instances initialize with a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end
end
