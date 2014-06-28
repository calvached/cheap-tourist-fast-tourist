require 'itinerary'

describe Itinerary do
  it 'creates an object' do
    itinerary = Itinerary.new('A', 'B', '09:00', '10:00', '100.00')

    expect(itinerary.from).to eq('A')
    expect(itinerary.to).to eq('B')
    expect(itinerary.departure).to eq('09:00')
    expect(itinerary.arrival).to eq('10:00')
    expect(itinerary.price).to eq('100.00')
    expect(itinerary.duration).to be_nil
  end
end
