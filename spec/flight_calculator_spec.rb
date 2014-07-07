require 'flight_calculator'

describe FlightCalculator do

  it 'calculates the total price' do
    prices = [10.20, 12.20, 14.20]

    expect(FlightCalculator.total(prices)).to eq(36.60)
  end

  it 'returns the flight with the shortest duration' do
    flights =[
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"10:00", :price=>50.0, :duration=>2.0},
        {:from=>"A", :to=>"C", :departure=>"14:00", :arrival=>"15:30", :price=>175.0, :duration=>1.5},
        {:from=>"B", :to=>"C", :departure=>"10:00", :arrival=>"11:00", :price=>75.0, :duration=>1.0}
      ]

    expect(FlightCalculator.get_shortest_duration(flights)).to eq({:from=>"B", :to=>"C", :departure=>"10:00", :arrival=>"11:00", :price=>75.0, :duration=>1.0})
  end

  it 'gets the cheapest flight' do
    flights = [
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :departure=>"12:00", :arrival=>"13:00", :price=>300.0, :duration=>1.0},
        {:from=>"A", :to=>"C", :departure=>"14:00", :arrival=>"15:30", :price=>175.0, :duration=>1.5},
        {:from=>"B", :to=>"C", :departure=>"10:00", :arrival=>"11:00", :price=>75.0, :duration=>1.0}
      ]

      expect(FlightCalculator.get_cheapest(flights)).to eq({:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0})
  end

end

# A file will have a set number of test cases
# Each test case has various flights (first line indicates # of flights)
# For each test case we must figure out which combination of flights is best, travelers can take a flight with stops.
# The origin point is A the destination point is Z

# A < B < C < Z

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
