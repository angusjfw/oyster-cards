require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }

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

  describe '#deduct!' do
    it 'can deduct money from card' do
      card.top_up! 20
      card.deduct! 10
      expect(card.balance).to eq 10
    end
  end

  describe '#in_journey?' do
    it 'can check if in journey' do
      expect(card).to_not be_in_journey
    end
  end

  describe '#touch_in!' do
    it 'tapping in sets card state to in use' do
      card.touch_in!
      expect(card).to be_in_journey
    end
  end

  describe '#touch_out!' do
    it 'touching out sets card state to not in use' do
      card.touch_in!
      card.touch_out!
      expect(card).to_not be_in_journey
    end
  end
end
