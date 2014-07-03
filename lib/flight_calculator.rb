require 'time'

class FlightCalculator
  attr_accessor :groups

  def initialize(flights_file)
    @groups = Parser.new.parse(flights_file)
    set_durations
  end

  def sort_by_price
    @groups.each_with_index do |group, i|
      @groups[i] = group.sort_by { |flight| flight[:price] }
    end
  end

  def sort_by_duration
    @groups.each_with_index do |group, i|
      @groups[i] = group.sort_by { |flight| flight[:duration] }
    end
  end

  def total(prices)
    (prices.reduce(:+) * 100).round / 100.0
  end

  def set_durations
    @groups.each do |group|
      group.each do |flight|
        flight[:duration] = convert_duration_to_hours(flight[:departure], flight[:arrival])
      end
    end
  end

  def convert_duration_to_hours(departure, arrival)
    minute = 60
    hour = 60.0

    (Time.parse(arrival) - Time.parse(departure)) / minute / hour
  end
end

