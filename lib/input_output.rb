class MyIO
  def in
    gets
  end

  def out(message)
    puts message
  end
end

class MockIO
  attr_accessor :in

  def out(message)
    message
  end
end
