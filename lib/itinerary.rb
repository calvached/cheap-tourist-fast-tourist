class Itinerary
  attr_reader :from, :to, :departure, :arrival, :price
  attr_accessor :duration

  def initialize(from, to, departure, arrival, price)
    @from = from
    @to = to
    @departure = departure
    @arrival = arrival
    @price = price
    @duration = nil
  end
end
