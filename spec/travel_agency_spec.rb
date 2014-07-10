require 'travel_agency'

describe TravelAgency do
  let(:agency) { TravelAgency.new }

  it 'finds direct flights' do
    agency.flights = [[
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"13:00", :price=>300.0, :duration=>1.0},
        {:from=>"A", :to=>"Z", :departure=>"14:00", :arrival=>"16:00", :price=>300.0, :duration=>1.0},
      ]]

    direct_flights = agency.get_direct_flights('A', 'Z')

    expect(direct_flights).to eq(
      [
        {:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"13:00", :price=>300.0, :duration=>1.0},
        {:from=>"A", :to=>"Z", :departure=>"14:00", :arrival=>"16:00", :price=>300.0, :duration=>1.0}
      ])
  end

  it 'selects all flights that begin at the specified origin point' do
    flight_group = [
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"C", :departure=>"14:00", :arrival=>"15:30", :price=>175.0, :duration=>1.5},
        {:from=>"B", :to=>"Z", :departure=>"15:00", :arrival=>"16:30", :price=>250.0, :duration=>1.5},
        {:from=>"C", :to=>"Z", :departure=>"16:00", :arrival=>"19:00", :price=>100.0, :duration=>3.0}
      ]

    expect(agency.flights_departing_from('A', flight_group)).to eq(
      [
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"C", :departure=>"14:00", :arrival=>"15:30", :price=>175.0, :duration=>1.5}
      ])
  end

  xit 'selects a booking' do
    agency.calc.groups = [[
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"13:00", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"Z", :departure=>"14:00", :arrival=>"16:00", :price=>300.0, :duration=>1.0},
      ]]

    expect(agency.select_booking('cheap')).to eq({:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"13:00", :price=>100.0, :duration=>1.0})
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

  it 'returns built flights' do
    flights = [
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"H", :price=>300.0, :duration=>2.0},
        {:from=>"H", :to=>"Z", :price=>300.0, :duration=>2.0},
        {:from=>"A", :to=>"C", :price=>200.0, :duration=>1.5},
        {:from=>"C", :to=>"K", :price=>400.0, :duration=>2.5},
        {:from=>"K", :to=>"Z", :price=>400.0, :duration=>2.5},
      ]

    expect(agency.indirect_flights(flights)).to eq([
        {:from=>"A", :to=>"Z", :price=>700.0, :duration=>5.0},
        {:from=>"A", :to=>"Z", :price=>1000.0, :duration=>6.5},
      ])
  end

  it 'builds three flights' do
    flights = [
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"D", :to=>"E", :price=>100.0, :duration=>1.0},
        {:from=>"D", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"E", :to=>"Q", :price=>100.0, :duration=>1.0},
        {:from=>"Q", :to=>"Z", :price=>100.0, :duration=>1.0},
    ]

    expect(agency.flight_builder(flights, 'A')).to eq([
      [
        {:from=>"Q", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"E", :to=>"Q", :price=>100.0, :duration=>1.0},
        {:from=>"D", :to=>"E", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
      ],
      [
        {:from=>"D", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
      ],
      [
        {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
      ],
    ])
  end

  xit 'builds four flights' do
    flights = [
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"E", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"D", :to=>"E", :price=>100.0, :duration=>1.0},
        {:from=>"D", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"E", :to=>"Q", :price=>100.0, :duration=>1.0},
        {:from=>"Q", :to=>"Z", :price=>100.0, :duration=>1.0},
    ]

    expect(agency.flight_builder(flights, 'A')).to eq([
      [
        {:from=>"Q", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"E", :to=>"Q", :price=>100.0, :duration=>1.0},
        {:from=>"D", :to=>"E", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
      ],
      [
        {:from=>"Q", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"E", :to=>"Q", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"E", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
      ],
      [
        {:from=>"D", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
      ],
      [
        {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
      ],
    ])
  end

  xit 'calculates a total duration for built flights' do
    #built_flights = [
    #    {:from=>"Q", :to=>"Z", :price=>100.0, :duration=>1.0},
    #    {:from=>"E", :to=>"Q", :price=>100.0, :duration=>1.0},
    #    {:from=>"D", :to=>"E", :price=>100.0, :duration=>1.0},
    #    {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
    #    {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
    #  ],
    #  [
    #    {:from=>"D", :to=>"Z", :price=>100.0, :duration=>1.0},
    #    {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
    #    {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
    #  ],
    #  [
    #    {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
    #    {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0}
    #  ]
    #]
  end

  xit 'calculates a total price for built flights' do
  end

end

# A file will have a set number of test cases
# Each test case has various flights (first line indicates # of flights)
# For each test case we must figure out which combination of flights is best, travelers can take a flight with stops.
# The origin point is A the destination point is Z

# A < B < C < Z

#   IF flights are sorted by cheapest amount then find the first flight that matches the origin point. Determine the destination point of the flight, if it is not 'Z' then look for the next flight that is == to the destination point, but the new destination point must be greater than the last destination point (or else we go backwards).

#   IF flights are sorted by the shortest time then find all the flights that have an origin of 'A', then find the flight that travels the furthest in the shortest amount of time.

# get_cheapest will take a set of flights from A - Z and select the cheapest one from that group.

# get_shortest_duration will take a set of flights from A - Z and select the fastest one from that group.
