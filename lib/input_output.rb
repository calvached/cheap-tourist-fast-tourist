class IO
  attr_reader :input, :output

  def initialize(input = $stdin, output = $stdout)
    @input = input
    @output = output
  end

  def in
    print "Please input an option. Choose 'cheap' or 'fast': "
    @input.gets.chomp
  end

  def out(messages)
    messages.each { |message| @output.puts message }
  end
end

class MockIO
  def self.out(messages)
    messages
  end
end
