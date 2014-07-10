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
