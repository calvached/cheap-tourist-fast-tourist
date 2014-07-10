require 'flight_calculator'
require 'parser'

class TravelAgency
  attr_accessor :flights

  def initialize
    @flights = Parser.parse('data/sample-input.txt')
  end

  def select_booking(option)
    if option == 'cheap'
    elsif option == 'fast'
    else
      puts 'Invalid option'
    end
  end

  def get_direct_flights(origin, destination)
    @flights.each do |group|
      direct_flights = group.select { |flight| flight[:from] == origin && flight[:to] == destination }
      direct_flights ? (return direct_flights) : nil
    end
  end

  def calculate_trip(built_itineraries)
    built_itineraries.reduce([]) do |trips, itinerary|
      prices = []
      durations = []

      itinerary.each do |flight|
        prices << flight[:price]
        durations << flight[:duration]
      end

      trips << {from: 'A', to: 'Z', price: total(prices), duration: total(durations)}
    end
  end

  def total(addends)
    addends.reduce(:+)
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
