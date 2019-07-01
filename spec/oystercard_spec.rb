# frozen_string_literal: true

require 'Oystercard'

describe Oystercard do
  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'new instances initialize with a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument}
    it 'adds 10 to our balance' do
    expect { subject.top_up(10) }.to change { subject.balance }.from(0).to(10)
  end 
end
end
