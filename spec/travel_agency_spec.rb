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

  xit 'selects an itinerary' do
    agency.calc.groups = [[
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00", :price=>50.0, :duration=>1.0},
        {:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"13:00", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"Z", :departure=>"14:00", :arrival=>"16:00", :price=>300.0, :duration=>1.0},
      ]]

    expect(agency.select_itinerary('cheap')).to eq({:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"13:00", :price=>100.0, :duration=>1.0})
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

end
