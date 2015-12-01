require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }
  let(:station) { double :station }
  let(:station2) { double :station2 }

  describe '#balance' do
    it "has a balance" do
      expect(card).to respond_to(:balance)
    end

    it 'is initialized with balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up!' do
    it 'can be topped up' do
      card.top_up! 10
      expect(card.balance).to eq 10
    end

    it 'has a maximum balance of 90' do
      card.top_up! Oystercard::BALANCE_LIMIT
      expect{card.top_up! 1}.to raise_error 'Cannot exceed balance of 90!'
    end
  end

  describe '#in_journey?' do
    it 'can check if in journey' do
      expect(card).to_not be_in_journey
    end
  end

  describe '#touch_in!' do
    it 'sets card state to in use' do
      card.top_up! Oystercard::TRAVEL_BALANCE
      card.touch_in! station
      expect(card).to be_in_journey
    end

    it 'must have at least £1 balance to touch in' do
      expect{card.touch_in! station }.to raise_error "Top up needed!"
    end

    it 'tapping in stores the entry station' do
      card.top_up! Oystercard::TRAVEL_BALANCE
      card.touch_in! station
      expect(card.journey[:entry_station]).to eq station
    end
  end

  describe '#touch_out!' do
    it 'sets card state to not in use' do
      card.top_up! Oystercard::TRAVEL_BALANCE
      card.touch_in! station
      card.touch_out! station
      expect(card).to_not be_in_journey
    end

    it 'deducts fare from balance' do
      card.top_up! Oystercard::TRAVEL_BALANCE
      card.touch_in! station
      expect{card.touch_out! station}.to change{card.balance}.by (-Oystercard::FARE)
    end

    it 'sets the entry_station to nil' do
      card.top_up! Oystercard::TRAVEL_BALANCE
      card.touch_in! station
      card.touch_out! station
      expect(card.entry_station).to eq nil
    end
  end

  describe '#history' do
    it 'is an empty array by default' do
      expect(card.history).to eq []
    end

    it 'returns array of journeys taken' do
      journey = {entry_station: station, exit_station: station2}
      2.times {
        card.top_up! Oystercard::FARE
        card.touch_in! station
        card.touch_out! station2
      }
      expect(card.history).to eq([journey, journey])
    end 
  end
end
