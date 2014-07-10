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

  def indirect_flights(flights)
    built_flights = []
    a_flights = flights_departing_from('A', flights)

    a_flights.each do |flight|
      stop = flights_departing_from(flight[:to], flights)
      stop_2 = flights_departing_from(stop.first[:to], flights)
      sum = flight[:price] + stop.first[:price] + stop_2.first[:price]
      total_duration = flight[:duration] + stop.first[:duration] + stop_2.first[:duration]

      built_flights << {from: 'A', to: 'Z', price: sum, duration: total_duration}
    end

    built_flights
  end

  def flights_departing_from(origin, flight_group)
    flight_group.select { |flight| flight[:from] == origin }
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

#total_prices = 0
    #total_durations = 0

    #collected_flights.each do |flight|
    #  total_prices += flight[:price]
    #  total_durations += flight[:duration]
    #end

    #[{from: 'A', to: 'Z', price: total_prices, duration: total_durations}]
end

# Travel Agency
# Make new flights sets and calculate the new price and duration.
# Get all flights with 'A'
  # for each flight find the "to" and search for the next flight with that origin
