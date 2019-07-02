require_relative '../../lib/tickets/repositories/user_repository.rb'

RSpec.describe UserRepository do
  describe 'initialize' do
    subject { described_class.new }

    let(:parser) { instance_double(Yajl::Parser) }

    before do
      allow(Yajl::Parser).to receive(:new).and_return(parser)
      allow(parser).to receive(:parse)
    end

    it 'returns the instance' do
      expect(subject).to be_an_instance_of(described_class)
    end

    it 'parses the data' do
      subject
      expect(parser).to have_received(:parse)
    end
  end

  describe '#find' do
    let(:id) { 1 }

    subject { described_class.new.find(id) }

    it 'returns a User' do
      expect(subject).to be_a_kind_of(User)
    end

    it 'returns the correct id' do
      expect(subject._id).to eq(id)
    end
  end
end
