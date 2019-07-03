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

  describe '#by_organization' do
    let(:org_id) { 101 }

    subject { described_class.new.by_organization(org_id) }

    it 'returns the correct number of users' do
      expect(subject.count).to eq(4)
    end

    it 'returns only users with the specified org id' do
      expect(subject).to all(have_attributes(organization_id: org_id))
    end
  end
end
