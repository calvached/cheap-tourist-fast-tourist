require 'travel_agency'
require 'input_output'

describe TravelAgency do
  let(:agency) { TravelAgency.new(MockIO.new) }

  it 'selects the cheapest itinerary' do
    agency.flights = [[
        {:from=>"A", :to=>"B", :price=>1.0, :departure=>"12:00", :arrival=>"14:00"},
        {:from=>"B", :to=>"D", :price=>100.0, :departure=>"14:00", :arrival=>"15:00"},
        {:from=>"B", :to=>"E", :price=>100.0, :departure=>"14:00", :arrival=>"16:00"},
        {:from=>"B", :to=>"Z", :price=>1.0, :departure=>"15:00", :arrival=>"17:00"},
        {:from=>"D", :to=>"E", :price=>100.0, :departure=>"12:00", :arrival=>"13:00"},
        {:from=>"D", :to=>"Z", :price=>100.0, :departure=>"16:00", :arrival=>"17:00"},
        {:from=>"E", :to=>"Q", :price=>100.0, :departure=>"17:00", :arrival=>"18:00"},
        {:from=>"Q", :to=>"Z", :price=>100.0, :departure=>"19:00", :arrival=>"20:00"},
    ]]

    mock = agency.io
    mock.in = 'cheap'

    expect(agency.select_itinerary).to eq([{:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"17:00", :price=>2.0, :duration=>5.0}])
  end

  it 'selects the fastest itinerary' do
    agency.flights = [[
        {:from=>"A", :to=>"B", :price=>300.0, :departure=>"12:00", :arrival=>"13:00"},
        {:from=>"B", :to=>"D", :price=>100.0, :departure=>"14:00", :arrival=>"19:00"},
        {:from=>"B", :to=>"E", :price=>100.0, :departure=>"14:00", :arrival=>"16:00"},
        {:from=>"B", :to=>"Z", :price=>200.0, :departure=>"14:00", :arrival=>"15:00"},
        {:from=>"D", :to=>"E", :price=>100.0, :departure=>"13:00", :arrival=>"14:00"},
        {:from=>"D", :to=>"Z", :price=>100.0, :departure=>"16:00", :arrival=>"17:00"},
        {:from=>"E", :to=>"Q", :price=>100.0, :departure=>"17:00", :arrival=>"18:00"},
        {:from=>"Q", :to=>"Z", :price=>100.0, :departure=>"19:00", :arrival=>"20:00"},
    ]]

    mock = agency.io
    mock.in = 'fast'

    expect(agency.select_itinerary).to eq([{:from=>"A", :to=>"Z", :departure=>"12:00", :arrival=>"15:00", :price=>500.0, :duration=>3.0}])
  end
end
