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
end
