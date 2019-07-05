 require 'journey'
describe Journey do
  let(:station) { double :station, zone: 1}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.finish(station)).to eq(subject)
  end

  context 'given an entry station' do
    subject {described_class.new(entry_station: station)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:other_station) { double :other_station, zone: 1 }

      before do
        subject.finish(other_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it "knows if a journey is complete" do
        expect(subject).to be_complete
      end
    end
  end
  let(:holborn) { double :Station, name: 'holborn', zone: 1 }
  let(:liverpool) { double :Station, name: 'liverpool', zone: 1 }
  let(:amersham) { double :Station, name: 'Amersham', zone: 9 }
  it 'calculates fares correctly' do
    journey1 = Journey.new(entry_station: holborn, exit_station: liverpool)
    expect(journey1.fare). to eq 1
    journey2 = Journey.new(entry_station: holborn, exit_station: amersham)
    expect(journey2.fare). to eq 9
    journey3 = Journey.new(entry_station: amersham, exit_station: holborn)
    expect(journey3.fare). to eq 9
  end
end