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
      departures = []
      arrivals = []

      itineraries_with_durations.each do |flight|
        prices << flight[:price]
        durations << flight[:duration]
        departures << flight[:departure]
        arrivals << flight[:arrival]
      end

       trips << {from: 'A', to: 'Z', departure: departures.min, arrival: arrivals.max, price: total(prices), duration: get_total_duration_in_hours(departures.min, arrivals.max)}
    end
  end

  private
  def self.total(addends)
    addends.reduce(:+)
  end

  def self.set_durations(flights)
    flights.each do |flight|
      flight[:duration] = get_total_duration_in_hours(flight[:departure], flight[:arrival])
     end
  end

  def self.get_total_duration_in_hours(departure, arrival)
    minute = 60
    hour = 60.0

    (Time.parse(arrival) - Time.parse(departure)) / minute / hour
  end
end

