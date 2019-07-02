# frozen_string_literal: true

require 'Oystercard'

describe Oystercard do
  max_balance = Oystercard::DEFAULT_MAXIMUM
  min_balance = Oystercard::MININMUM_TOUCH_IN
  let (:station) { double :fake_station}
  describe '#journeys' do
    it { is_expected.to respond_to(:journeys) }
    it 'new cards have empty journeys' do
      expect(subject.journeys).to eq Hash.new
    end
    it 'stores a journey' do
      subject.top_up(max_balance)
      test = { Entry: :station, Exit: :station } 
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.journeys).to eq test
    end
  end
  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'new instances initialize with a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'adds 10 to our balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.from(0).to(10)
    end
    it 'raises exception when top-up exceeds default maximum' do
      subject.top_up(max_balance)
      expect { subject.top_up(2) }.to raise_error "error: top-up exceeds maximum (#{Oystercard::DEFAULT_MAXIMUM})"
    end
  end
#  describe '#deduct' do
    # it { is_expected.to respond_to(:deduct).with(1).argument }
    # it 'deducts 10 from our balance' do
    #   subject.top_up(20)
    #   expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
    # end
    # it 'raises exception when deduct exceeds balance' do
    #   subject.top_up(20)
    #   expect { subject.deduct(30) }.to raise_error 'error: insufficient funds'
    # end

  describe '#in_journey' do
    # it 'new instances start outside of a journey' do
    #   expect(subject.in_journey?).to eq false
    # end
  end
  describe '#touch_in' do
    # it 'causes in_journey? to return true' do
    #   subject.top_up(max_balance)
    #   subject.touch_in(station)
    #   expect(subject.in_journey?).to eq true
    # end
    it 'raises error if already in journey' do
      subject.top_up(max_balance)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to raise_error 'error: Already in journey'
    end
    it 'raises error if balance is under minimum' do
      expect { subject.touch_in(station) }.to raise_error 'error: insufficient funds'
    end
    it 'stores the entry station' do
      subject.top_up(max_balance)
      subject.touch_in(station)
      expect(subject.journeys[:Entry]).to eq station
    end


  end
  describe '#touch_out' do
    # it 'causes in_journey? to return false' do
    #   subject.top_up(max_balance)
    #   subject.touch_in(station)
    #   subject.touch_out
    #   expect(subject.in_journey?).to eq false
    # end
    it 'raises error if not in journey' do
      expect { subject.touch_out(station) }.to raise_error 'error: Not in journey'
    end
    it 'deducts fare price when you tap out' do
      subject.top_up(min_balance)
      subject.touch_in(station)
      expect {subject.touch_out(station)}.to change{subject.balance}.by(-1)

    end
    # it 'forgets entry station when tapping out' do
    #   subject.top_up(min_balance)
    #   subject.touch_in(station)
    #   subject.touch_out(station)
    #   expect(subject.entry_station).to eq nil
    # end


  end
end
