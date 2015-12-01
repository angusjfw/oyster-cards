require 'journey'

describe Journey do
  let(:station) {double :station}
  subject(:journey) { described_class.new(station) }

  it 'is initialized with an entry station' do
    expect(journey.entry).to eq station
  end

  it 'responds to exit_station' do
    expect(journey).to respond_to(:exit_station)
  end

  describe '#fare' do
    it 'gives the fare' do
      journey.exit_station = station
      expect(journey.fare).to eq Journey::FARE
    end

    it 'the fare is a penalty fare if touch in/out is missing' do
      
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end
