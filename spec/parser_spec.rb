require 'parser'

describe Parser do
  it 'returns sets of data' do
    file = 'data/sample-input.txt'
    parsed_data = Parser.new.parse(file)
    first_set_of_flights = parsed_data.first
    second_set_of_flights = parsed_data[1]

    expect(first_set_of_flights.first.from).to eq('A')
    expect(first_set_of_flights.first.to).to eq('B')
    expect(first_set_of_flights.first.departure).to eq('09:00')
    expect(first_set_of_flights.first.arrival).to eq('10:00')
    expect(first_set_of_flights.first.price).to eq(100.0)

    expect(second_set_of_flights.first.from).to eq('A')
    expect(second_set_of_flights.first.to).to eq('B')
    expect(second_set_of_flights.first.departure).to eq('08:00')
    expect(second_set_of_flights.first.arrival).to eq('09:00')
    expect(second_set_of_flights.first.price).to eq(50.0)

  end
end

