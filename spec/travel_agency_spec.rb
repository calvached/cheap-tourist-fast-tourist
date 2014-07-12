require 'travel_agency'

describe TravelAgency do
  let(:agency) { TravelAgency.new }

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

  it 'selects an itinerary' do
    agency.flights = [[
        {:from=>"A", :to=>"B", :price=>100.0, :departure=>"12:00", :arrival=>"13:00"},
        {:from=>"B", :to=>"D", :price=>100.0, :departure=>"14:00", :arrival=>"15:00"},
        {:from=>"B", :to=>"E", :price=>100.0, :departure=>"14:00", :arrival=>"16:00"},
        {:from=>"B", :to=>"Z", :price=>100.0, :departure=>"15:00", :arrival=>"16:00"},
        {:from=>"D", :to=>"E", :price=>100.0, :departure=>"12:00", :arrival=>"13:00"},
        {:from=>"D", :to=>"Z", :price=>100.0, :departure=>"16:00", :arrival=>"17:00"},
        {:from=>"E", :to=>"Q", :price=>100.0, :departure=>"17:00", :arrival=>"18:00"},
        {:from=>"Q", :to=>"Z", :price=>100.0, :departure=>"19:00", :arrival=>"20:00"},
    ]]

    expect(agency.select_itinerary('cheap')).to eq([{:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"16:00", :price=>200.0, :duration=>4.0}])
  end

  it 'builds three flights' do
    flights = [
      {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0},
      {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
      {:from=>"B", :to=>"D", :price=>100.0, :duration=>1.0},
      {:from=>"D", :to=>"E", :price=>100.0, :duration=>1.0},
      {:from=>"D", :to=>"Z", :price=>100.0, :duration=>1.0},
      {:from=>"E", :to=>"Q", :price=>100.0, :duration=>1.0},
      {:from=>"Q", :to=>"Z", :price=>100.0, :duration=>1.0},
    ]

    expect(agency.flight_builder(flights)).to match_array([
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

  it 'does not return a flight that does not reach Z' do
    flights = [
      {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0},
      {:from=>"B", :to=>"R", :price=>100.0, :duration=>1.0},
    ]

    expect(agency.flight_builder(flights)).to match_array([])
  end

  it "only returns flights that have a destination greater than the previous origin" do
    flights = [
      {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0},
      {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
      {:from=>"B", :to=>"A", :price=>100.0, :duration=>1.0},
    ]

    expect(agency.flight_builder(flights)).to match_array([
      [
        {:from=>"B", :to=>"Z", :price=>100.0, :duration=>1.0},
        {:from=>"A", :to=>"B", :price=>100.0, :duration=>1.0},
      ]
    ])
  end

  it "only returns flights whose departure time is greater than the previous arrival time" do
    flights = [
      {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00"},
      {:from=>"B", :to=>"Z", :departure=>"10:00", :arrival=>"11:00"},
      {:from=>"B", :to=>"Z", :departure=>"07:00", :arrival=>"08:00"},
    ]

    expect(agency.flight_builder(flights)).to match_array([
      [
        {:from=>"B", :to=>"Z", :departure=>"10:00", :arrival=>"11:00"},
        {:from=>"A", :to=>"B", :departure=>"08:00", :arrival=>"09:00"},
      ]
    ])
  end

  it 'builds four flights' do
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

    expect(agency.flight_builder(flights)).to match_array([
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
