require 'travel_agency'

describe TravelAgency do
  let(:agency) { TravelAgency.new }

  it 'finds direct flights' do
    direct_flights = agency.get_direct_flights('A', 'Z')

    expect(direct_flights.first[:duration]).to eq(2.0)
  end

  it 'selects all flights that begin at the origin point' do
    flight_group = [
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :departure=>"12:00", :arrival=>"13:00", :price=>300.0, :duration=>1.0},
        {:from=>"A", :to=>"C", :departure=>"14:00", :arrival=>"15:30", :price=>175.0, :duration=>1.5},
        {:from=>"B", :to=>"C", :departure=>"10:00", :arrival=>"11:00", :price=>75.0, :duration=>1.0},
        {:from=>"B", :to=>"Z", :departure=>"15:00", :arrival=>"16:30", :price=>250.0, :duration=>1.5},
        {:from=>"C", :to=>"B", :departure=>"15:45", :arrival=>"16:45", :price=>50.0, :duration=>1.0},
        {:from=>"C", :to=>"Z", :departure=>"16:00", :arrival=>"19:00", :price=>100.0, :duration=>3.0}
      ]

    expect(agency.flights_departing_from('A', flight_group)).to eq(
      [
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :departure=>"12:00", :arrival=>"13:00", :price=>300.0, :duration=>1.0},
        {:from=>"A", :to=>"C", :departure=>"14:00", :arrival=>"15:30", :price=>175.0, :duration=>1.5}
      ])
  end

  xit 'finds indirect flights' do
    agency.calc.groups = [
      [
        {:from=>"A", :to=>"B", :departure=>"09:00", :arrival=>"10:00", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"Z", :departure=>"11:30", :arrival=>"13:30", :price=>100.0, :duration=>2.0}
      ],
      [
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :departure=>"12:00", :arrival=>"13:00", :price=>300.0, :duration=>1.0},
        {:from=>"A", :to=>"C", :departure=>"14:00", :arrival=>"15:30", :price=>175.0, :duration=>1.5},
        {:from=>"B", :to=>"C", :departure=>"10:00", :arrival=>"11:00", :price=>75.0, :duration=>1.0},
        {:from=>"B", :to=>"Z", :departure=>"15:00", :arrival=>"16:30", :price=>250.0, :duration=>1.5},
        {:from=>"C", :to=>"B", :departure=>"15:45", :arrival=>"16:45", :price=>50.0, :duration=>1.0},
        {:from=>"C", :to=>"Z", :departure=>"16:00", :arrival=>"19:00", :price=>100.0, :duration=>3.0}
      ]]

    indirect_flights = agency.get_indirect_flights('A', 'Z')

    expect(indirect_flights[0][:duration]).to eq(1.0)
    expect(indirect_flights[1][:duration]).to eq(2.0)
  end

  xit 'finds the cheapest flight' do
    cheapest_flights = agency.get_cheapest_price('A', 'Z')

    expect(cheapest_flights[0][:price]).to eq(100.0)
    expect(cheapest_flights[1][:price]).to eq(100.0)
    expect(cheapest_flights[2][:price]).to eq(50.0)
    expect(cheapest_flights[3][:price]).to eq(75.0)
    expect(cheapest_flights[4][:price]).to eq(100.0)
  end

  xit 'finds the flight with the shortest duration' do
    shortest_duration = agency.get_shortest_duration('A', 'Z')

    expect(shortest_duration[0][:duration]).to eq(2.0)
    expect(shortest_duration[0][:price]).to eq(300.0)
    expect(shortest_duration[1][:duration]).to eq(1.0)
    expect(shortest_duration[1][:price]).to eq(300.0)
    expect(shortest_duration[2][:duration]).to eq(1.5)
    expect(shortest_duration[2][:price]).to eq(250.0)
  end

  xit 'returns specific flights' do
    expect(agency.get_flights_for('A', 'Z')).to be_kind_of(Array)
    expect(agency.get_flights_for('A', 'Z')).to_not be_empty
    expect(agency.get_flights_for('A', '4')).to be_empty
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

# Travel Agency
#   sorts through trips
#     get_cheapest_price
#     get_shortest_duration

