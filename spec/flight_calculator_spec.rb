require 'flight_calculator'

describe FlightCalculator do
  let(:calc) { FlightCalculator.new('data/sample-input.txt') }

  it 'calculates a duration' do
    departure = '12:00'
    arrival = '14:00'

    expect(calc.convert_duration_to_hours(departure, arrival)).to eq(2.0)
  end

  it 'calculates the total price' do
    prices = [10.20, 12.20, 14.20]

    expect(calc.total(prices)).to eq(36.60)
  end

  it 'adds a flight duration to all flights' do
    calc.set_durations
    first_set_of_flights = calc.groups.first
    second_set_of_flights = calc.groups[1]

    expect(first_set_of_flights.first[:duration]).to eq(1.0)
    expect(second_set_of_flights[2][:duration]).to eq(1.5)
  end

  it 'sorts all flights by price (low to high)' do
    calc.sort_by_price
    first_set_of_flights = calc.groups.first
    second_set_of_flights = calc.groups[1]

    expect(first_set_of_flights.first[:price]).to eq(100.0)
    expect(second_set_of_flights[2][:price]).to eq(75.0)
  end

  it 'sorts all flights by duration (low to high)' do
    calc.set_durations
    calc.sort_by_duration
    first_set_of_flights = calc.groups.first
    second_set_of_flights = calc.groups[1]

    expect(first_set_of_flights.first[:duration]).to eq(1.0)
    expect(second_set_of_flights[2][:duration]).to eq(1.0)
  end

end

# A file will have a set number of test cases
# Each test case has various flights (first line indicates # of flights)
# For each test case we must figure out which combination of flights is best, travelers can take a flight with stops.
# The origin point is A the destination point is Z

# A < B < C < Z

# Based on the tourist, sort through the data by the cheapest amount or shortest travel time.
#   IF flights are sorted by cheapest amount then find the first flight that matches the origin point. Determine the destination point of the flight, if it is not 'Z' then look for the next flight that is == to the destination point, but the new destination point must be greater than the last destination point (or else we go backwards).

#   IF flights are sorted by the shortest time then find all the flights that have an origin of 'A', then find the flight that travels the furthest in the shortest amount of time.

# Trip Calculator
#   Gets all parsed flight data
#   Calculates the duration of each flight (departure - arrival)
#   sort flights by price (each group is sorted individually)
#   get cheapest flight('A', 'Z')
#   sort flights by duration
#   get fastest flight('A', 'Z')

# Travel Agency
#     get_cheapest_price
#     get_shortest_duration
#
