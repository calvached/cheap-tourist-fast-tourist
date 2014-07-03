class Parser
  def parse(flights_file)
    quantity_in_groups = []
    itineraries = []

    File.foreach(flights_file) do |line|
      if group_quantity_in?(line)
        quantity_in_groups << line
      elsif line =~ flight_itinerary_pattern
        itineraries << { from: format(line)[0],
                         to: format(line)[1],
                         departure: format(line)[2],
                         arrival: format(line)[3],
                         price: format(line)[4].to_f }
      end
    end

    seperate_into_groups(itineraries, quantity_in_groups[1..-1])
  end

  private
  def group_quantity_in?(line)
    !line.scan(/^\d+/).empty?
  end

  def format(line)
    line.strip.split(' ')
  end

  def seperate_into_groups(itineraries, quantity_in_groups)
    quantity_in_groups.reduce([]) do |group, number|
      group << itineraries.shift(number.to_i)
    end
  end

  def flight_itinerary_pattern
    /\w{1}\s\w{1}\s\d+:\d+\s\d+:\d+\s\d+\.\d+/
  end
end
