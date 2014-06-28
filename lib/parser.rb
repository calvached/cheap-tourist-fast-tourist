require_relative 'itinerary'

class Parser
  def parse(file)
    number_for_groups = []
    matched_data = []

    File.foreach(file) do |itinerary|
      if !itinerary.scan(/^\d+/).empty?
        number_for_groups << itinerary
      elsif itinerary =~ data_pattern
        from = extract_data(itinerary)[0]
        to = extract_data(itinerary)[1]
        departure = extract_data(itinerary)[2]
        arrival  = extract_data(itinerary)[3]
        price = extract_data(itinerary)[4].to_f

        matched_data << Itinerary.new(from, to, departure, arrival, price)
      end
    end

    seperate_into_groups(matched_data, number_for_groups[1..-1])
  end

  private
  def extract_data(itinerary)
    itinerary.strip.split(' ')
  end

  def seperate_into_groups(matched_data, number_for_groups)
    number_for_groups.reduce([]) do |grouped_data, number|
      grouped_data << matched_data.shift(number.to_i)
    end
  end

  def data_pattern
    /\w{1}\s\w{1}\s\d+:\d+\s\d+:\d+\s\d+\.\d+/
  end
end
