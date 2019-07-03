require 'Oystercard'

describe Oystercard do
  max_balance = Oystercard::DEFAULT_MAXIMUM
  min_balance = Oystercard::MININMUM_TOUCH_IN
  let (:station) { double :fake_station}
  let (:entry_station) { double :fake_station, touch_in: entry_station }
  let (:exit_station) { double :fake_station, touch_out: exit_station }
  let (:journey) { double :fake_journey, entry_station: entry_station, exit_station: exit_station }
  describe '#journeys' do
    it 'new cards have empty history' do
      expect(subject.print_history).to be_empty
    end
    # it 'stores a journey object' do
    #   subject.top_up(max_balance)
    #   subject.touch_in(:entry_station)
    #   subject.touch_out(:exit_station)
    #   subject.journeys[0] { should be_a(Journey) }
    # end
  end
  describe '#balance' do
    it { is_expected.to respond_to(:balance) }
    it 'new instances initialize with a balance of 0' do
      expect(subject.balance).to eq 0
    end
    it 'returns balance' do
      top_up_amount = rand(90)
      subject.top_up(top_up_amount)
      expect(subject.balance).to eq top_up_amount
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
  describe '#touch_in' do
    it 'raises error if balance is under minimum' do
      expect { subject.touch_in(station) }.to raise_error 'error: insufficient funds'
    end
    it 'subtracts penalty if last journey was not complete' do
      subject.top_up(max_balance)
      subject.touch_in(station)
      expect { subject.touch_in(station) }.to change { subject.balance }.by(-6)
    end
    it 'does not charge penalty fee for first touch in' do
      subject.top_up(max_balance)
      expect { subject.touch_in(station) }.to change { subject.balance }.by(0)
    end
  end
  describe '#touch_out' do
    it 'deducts fare price when you touch out' do
      subject.top_up(max_balance)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-1)
    end
    it 'deducts fee price when touching out, without touching in first' do
      subject.top_up(max_balance)
      expect {subject.touch_out(station) }. to change{ subject.balance }.by(-6)
    end
    it 'raises error if touching out, and unable to pay fee' do
      subject.top_up(min_balance)
      expect { subject.touch_out(station) }.to raise_error 'error: insufficient funds to pay fee'
    end
  end
end
