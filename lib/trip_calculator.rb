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

  def add_flight_durations
    @all_flights.each do |flights|
      flights.each do |flight|
        flight.duration = flight_duration_in_hours(flight.departure, flight.arrival)
      end
    end
  end
end

# Will take an origin and destination

# Need to figure out how get the 'cheapest' and 'shortest' flights for each group!
# [cheapest, shortest][cheapest, shortest]
