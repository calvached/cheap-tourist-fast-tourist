require 'time'

class FlightCalculator
  def self.get_cheapest(flights)
    flights.min_by { |flight| flight[:price] }
  end

  def self.get_shortest_duration(flights)
    flights.min_by { |flight| flight[:duration] }
  end

  def self.create_trips(built_itineraries)
    built_itineraries.reduce([]) do |trips, itinerary|
    itineraries_with_durations = set_durations(itinerary)
      prices = []
      durations = []

      itineraries_with_durations.each do |flight|
        prices << flight[:price]
        durations << flight[:duration]
      end

      trips << {from: 'A', to: 'Z', price: total(prices), duration: total(durations)}
    end
  end

  def self.total(addends)
    addends.reduce(:+)
  end

  private
  def self.set_durations(flights)
    flights.each do |flight|
      flight[:duration] = convert_duration_to_hours(flight[:departure], flight[:arrival])
     end
  end

  def self.convert_duration_to_hours(departure, arrival)
    minute = 60
    hour = 60.0

    (Time.parse(arrival) - Time.parse(departure)) / minute / hour
  end
end

