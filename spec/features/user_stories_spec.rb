require 'oystercard'
require 'station'

describe "User Stories" do
  let(:card) { Oystercard.new }
  station_name = "Aldgate"
  zone = 1
  station_name2 = "Euston"
  zone2 = 2
  let(:station) { Station.new(station_name, zone) }
  let(:station2) { Station.new(station_name2, zone2) }

  # In order to use public transport
  # As a customer
  # I want money on my card
  it 'card has a balance of 0' do
    expect(card.balance).to eq 0
  end

  #In order to keep using public transport
  #As a customer
  #I want to add money to my card
  it 'can add money to card' do
    card.top_up! 10
    expect(card.balance).to eq 10
  end

  #In order to protect my money from theft or loss
  #As a customer
  #I want a maximum limit (of £90) on my card
  it 'card has a maximum balance of 90' do
    card.top_up! Oystercard::BALANCE_LIMIT
    expect{card.top_up! 1}.to raise_error 'Cannot exceed balance of 90!'
  end

  #In order to get through the barriers.
  #As a customer
  #I need to touch in and out.
  it 'can touch in and touch out' do
    card.top_up! Oystercard::TRAVEL_BALANCE
    card.touch_in! station
    expect(card).to be_in_journey
  end

  #In order to pay for my journey
  #As a customer
  #I need to have the minimum amount (£1) for a single journey.
  it 'must have at least £1 balance to touch in' do
    expect{card.touch_in! station}.to raise_error "Top up needed!"
  end

  #In order to pay for my journey
  #As a customer
  #I need my fare deducted from my card
  #In order to pay for my journey
  #As a customer
  #When my journey is complete, I need the correct amount deducted from my card
  it 'tapping out deducts a fare from the balance' do
    card.top_up! Oystercard::TRAVEL_BALANCE
    card.touch_in! station
    expect {card.touch_out! station}.to change{card.balance}.by(-Oystercard::FARE)
  end

  #In order to pay for my journey
  #As a customer
  #I need to know where I've travelled from
  it 'tapping in stores the entry station' do
    card.top_up! Oystercard::TRAVEL_BALANCE
    card.touch_in! station
    expect(card.journey[:entry_station]).to eq station
  end

  #In order to know where I have been
  #As a customer
  #I want to see to all my previous trips
  it 'can see journey history' do
    journey = {entry_station: station, exit_station: station2}
    card.top_up! Oystercard::TRAVEL_BALANCE
    card.touch_in! station
    card.touch_out! station2
    expect(card.history).to eq([journey])
  end

  #In order to know how far I have travelled
  #As a customer
  #I want to know what zone a station is in
  it 'station has a zone' do
    expect(station.zone).to eq zone
  end

  #In order to be charged correctly
  #As a customer
  #I need a penalty charge deducted if I fail to touch in or out
  it 'deducts penalty fare if journey incompete' do
    card.top_up! Oystercard::TRAVEL_BALANCE
    expect{card.touch_out!}.to change{card.balance}.by(-Oystercard::PENALTY_FARE)
  end
end
