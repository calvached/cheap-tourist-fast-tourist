class MyIO
  def in
    out("Please input an option. Choose 'cheap' or 'fast': ")
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
