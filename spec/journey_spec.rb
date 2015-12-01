require 'journey'

describe Journey do
  let(:station) {double :station}
  subject(:journey) { described_class.new(station) }

  it 'has an entry station' do
    expect(journey.entry).to eq station
  end

  xit 'has an exit station' do
  end
end
