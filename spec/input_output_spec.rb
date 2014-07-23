require 'input_output'

describe IO do
  let(:test_input) { StringIO.new('test stuff\n') }
  let(:test_output) { StringIO.new }

  context 'Input' do
    xit 'receives user input' do
      test = IO.new(test_input, test_output)

      expect(test.input.string).to eq("test stuff\\n")
    end
  end

  context 'Output' do
    xit 'displays messages to the console' do
      test = IO.new(test_input, test_output)
      test.out(['test string'])

      expect(test.output.string).to eq("test string\n")
    end
  end
end

describe MockIO do
  let(:mock) { MockIO.new }

  xit 'takes user input' do
  end

  xit 'returns messages' do
    message = 'hello'

    expect(mock.out(messages)).to include('hello')
  end
end
