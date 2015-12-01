require 'station'

describe Station do
  station_name = "Euston"
  zone = 1
  subject(:station) {described_class.new(station_name, zone)}

  it 'station has a zone' do
    expect(station.zone).to eq zone
  end

  it 'station has a name' do
    expect(station.name).to eq station_name
  end
end
