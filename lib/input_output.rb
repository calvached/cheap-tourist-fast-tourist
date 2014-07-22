class IO
  def self.in
    print "Please input an option. Choose 'cheap' or 'fast': "
    gets.chomp
  end

  def self.out(messages)
    messages.each { |message| puts message }
  end
end

class MockIO
  # Figure out what the 'in' is
  def self.out(messages)
    messages
  end
end
