require 'time'

class FlightCalculator
  attr_accessor :groups

  def get_cheapest(flights)
    flights.min_by { |flight| flight[:price] }
  end

  def get_shortest_duration(flights)
    flights_with_durations = set_durations(flights)
    flights_with_durations.min_by { |flight| flight[:duration] }
  end

  def total(prices)
    (prices.reduce(:+) * 100).round / 100.0
  end

  def set_durations(flights)
    flights.each do |flight|
      flight[:duration] = convert_duration_to_hours(flight[:departure], flight[:arrival])
     end
  end

  def convert_duration_to_hours(departure, arrival)
    minute = 60
    hour = 60.0

    (Time.parse(arrival) - Time.parse(departure)) / minute / hour
  end
end

