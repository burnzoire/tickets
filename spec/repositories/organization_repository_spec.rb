require_relative '../../lib/tickets/repositories/organization_repository.rb'

RSpec.describe OrganizationRepository do
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
    let(:id) { 101 }

    subject { described_class.new.find(id) }

    it 'returns an Organization' do
      expect(subject).to be_a_kind_of(Organization)
    end

    it 'returns the correct id' do
      expect(subject._id).to eq(id)
    end
  end

  describe '#search' do
    let(:field) { 'name' }
    let(:keyword) { 'Enthaze' }
    subject { described_class.new.search(field, keyword) }

    it 'returns a single result' do
      expect(subject.count).to eq(1)
    end

    it 'returns the organization matching the search' do
      expect(subject.first).to have_attributes(
        name: 'Enthaze',
        _id: 101
      )
    end

    context 'with multiple hits' do
      let(:field) { 'details' }
      let(:keyword) { 'MegaCorp' }

      it 'returns 9 results' do
        expect(subject.count).to eq(9)
      end
    end
  end
end
