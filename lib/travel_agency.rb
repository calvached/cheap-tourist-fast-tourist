require 'flight_calculator'
require 'parser'

class TravelAgency
  attr_accessor :flights

  def initialize
    @flights = Parser.parse('data/sample-input.txt')
  end

  def select_itinerary(option)
    @flights.each do |group|
      built_flights = flight_builder(group, 'A')
      available_trips = FlightCalculator.create_trips(built_flights)

      if option == 'cheap'
        FlightCalculator.get_cheapest(available_trips)
      elsif option == 'fast'
        FlightCalculator.get_shortest_duration(available_trips)
      else
        puts 'Invalid option'
      end

    end
  end

  def get_direct_flights(origin, destination)
    @flights.each do |group|
      direct_flights = group.select { |flight| flight[:from] == origin && flight[:to] == destination }
      direct_flights ? (return direct_flights) : nil
    end
  end

  def flight_builder(available_flights, origin)
    legs = []
    selected_flights = flights_departing_from(origin, available_flights)

    selected_flights.each do |flight|
      if flight[:to] != 'Z'
        legs = flight_builder(available_flights, flight[:to])
        legs.each do |leg|
          leg << flight
        end
      else
        legs << [flight]
      end

      legs
    end

    legs
  end

  def flights_departing_from(origin, flight_group)
    flight_group.select { |flight| flight[:from] == origin }
  end

end
