require 'trip_calculator'

class TravelAgency
  def initialize
    @calc = TripCalculator.new('data/sample-input.txt')
  end

  def get_direct_flights(origin, destination)
    @calc.all_flights.each do |flights|
      direct_flights = flights.select { |flight| flight.from == origin && flight.to == destination }
      direct_flights ? (return direct_flights) : nil
    end
  end

  def get_indirect_flights(origin, destination)
    @calc.all_flights.each do |flights|
      indirect_flights = flights.select { |flight| flight.from == origin }
      p indirect_flights
    end
  end
end
