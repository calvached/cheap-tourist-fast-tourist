require 'flight_calculator'

class TravelAgency
  attr_accessor :calc

  def initialize
    @calc = FlightCalculator.new('data/sample-input.txt')
  end

  def get_direct_flights(origin, destination)
    @calc.groups.each do |flights|
      direct_flights = flights.select { |flight| flight[:from] == origin && flight[:to] == destination }
      direct_flights ? (return direct_flights) : nil
    end
  end

  def get_indirect_flights(origin, destination)
    @calc.groups.each do |flight_group|
      flights_departing_from(origin, flight_group)
    end
  end

  def flights_departing_from(origin, flight_group)
    flight_group.select { |flight| flight[:from] == origin }
  end

  def choose_cheapest_flight(selected_flights)
    selected_flights.first
  end
end
