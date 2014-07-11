require 'flight_calculator'
require 'parser'

class TravelAgency
  attr_accessor :flights

  def initialize
    @flights = Parser.parse('data/sample-input.txt')
  end

  def select_itinerary(option)
    @flights.each do |group|
      built_flights = flight_builder(group)
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

  def flight_builder(available_flights, origin = 'A', arrival_time = nil)
    legs = []
    selected_flights = select_available_flights(origin, available_flights, arrival_time)

    selected_flights.each do |flight|

      if flight[:to] != 'Z'
        indirect_flights = flight_builder(available_flights, flight[:to], flight[:arrival])
        indirect_flights.each do |indirect_flight|
          indirect_flight << flight
          legs << indirect_flight
        end
      else
        legs << [flight]
      end

    end

    legs
  end

  def select_available_flights(origin, available_flights, arrival_time)
    departing_flights = flights_departing_from(origin, available_flights)
    advancing_flights = filter_for_advancing_flights(departing_flights)
    filter_for_timely_flights(advancing_flights, arrival_time)
  end

  def flights_departing_from(origin, available_flights)
    available_flights.select { |flight| flight[:from] == origin }
  end

  def filter_for_advancing_flights(available_flights)
    available_flights.select { |flight| flight[:from] < flight[:to] }
  end

  def filter_for_timely_flights(available_flights, arrival_time)
    if arrival_time
      available_flights.select { |flight| flight[:departure] > arrival_time }
    else
      available_flights
    end
  end

end

# return start and end time