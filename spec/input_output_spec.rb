require 'input_output'

describe IO do
  let(:test_input) { StringIO.new('test stuff\n') }
  let(:test_output) { StringIO.new }

  context 'Input' do
    it 'receives user input' do
      test = IO.new(test_input, test_output)

      expect(test.input.string).to eq("test stuff\\n")
    end
  end

  context 'Output' do
    it 'displays messages to the console' do
      test = IO.new(test_input, test_output)
      test.out(['test string'])

      expect(test.output.string).to eq("test string\n")
    end
  end
end

describe MockIO do
  it 'returns messages' do
    messages = ['hello', 'world']

    expect(MockIO.out(messages)).to include('hello')
  end
end
