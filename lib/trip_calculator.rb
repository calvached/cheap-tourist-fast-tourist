require 'time'

class TripCalculator
  attr_accessor :all_flights

  def initialize(file)
    @all_flights = Parser.new.parse(file)
  end

  def flight_duration_in_hours(departure, arrival)
    (Time.parse(arrival) - Time.parse(departure)) / 60 / 60.0
  end

  def total(prices)
    (prices.reduce(:+) * 100).round / 100.0
  end

  def flight_durations
    @all_flights.each_with_index do |flights, i|
      flights.each do |flight|
        flight.duration = flight_duration_in_hours(flight.departure, flight.arrival)
      end
    end
  end

  def sort_flights_by_price
    @all_flights.each_with_index do |flights, i|
      @all_flights[i] = flights.sort_by { |flight| flight.price }
    end
  end

  def sort_flights_by_duration
    @all_flights.each_with_index do |flights, i|
      @all_flights[i] = flights.sort_by { |flight| flight.duration }
    end
  end
end

# Will take an origin and destination

# Need to figure out how get the 'cheapest' and 'shortest' flights for each group!
# [cheapest, shortest][cheapest, shortest]
