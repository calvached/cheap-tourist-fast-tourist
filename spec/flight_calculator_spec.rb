require 'flight_calculator'

describe FlightCalculator do

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

  it 'returns calculated trips' do
    built_itineraries = [
      [
        {:from=>"Q", :to=>"Z", :departure=>"08:00", :arrival=>"09:00", :price=>100.0},
        {:from=>"D", :to=>"Q", :departure=>"10:00", :arrival=>"11:00", :price=>100.0},
        {:from=>"B", :to=>"D", :departure=>"12:00", :arrival=>"13:00", :price=>100.0},
        {:from=>"A", :to=>"B", :departure=>"14:00", :arrival=>"15:00", :price=>100.0}
      ],
      [
        {:from=>"D", :to=>"Z", :departure=>"08:00", :arrival=>"09:00", :price=>100.0},
        {:from=>"B", :to=>"D", :departure=>"10:00", :arrival=>"11:00", :price=>100.0},
        {:from=>"A", :to=>"B", :departure=>"12:00", :arrival=>"13:00", :price=>100.0}
      ],
      [
        {:from=>"B", :to=>"Z", :departure=>"08:00", :arrival=>"09:00", :price=>100.0},
        {:from=>"A", :to=>"B", :departure=>"10:00", :arrival=>"11:00", :price=>100.0}
      ]
    ]

    expect(FlightCalculator.create_trips(built_itineraries)).to match_array([
      {:from=>"A", :to=>"Z", :price=>400.0, :duration=>7.0, :departure=>"08:00", :arrival=>"15:00"},
      {:from=>"A", :to=>"Z", :price=>300.0, :duration=>5.0, :departure=>"08:00", :arrival=>"13:00"},
      {:from=>"A", :to=>"Z", :price=>200.0, :duration=>3.0, :departure=>"08:00", :arrival=>"11:00"},
    ])
  end

  it 'calculates a total duration for built flights' do
    durations = [1.0, 1.5, 2.0, 3.0, 2.5]

    expect(FlightCalculator.total(durations)).to eq(10.0)
  end

  it 'calculates a total price for built flights' do
    prices = [100.0, 200.00, 150.00, 250.00]

    expect(FlightCalculator.total(prices)).to eq(700.00)
  end
end
