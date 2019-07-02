require 'station'

describe Station do
  it "should generate a station with a name and zone" do
    holborn = Station.new("Holborn", 1)
    expect( holborn.name ). to eq "Holborn"
    expect( holborn.zone ). to eq 1
  end
end