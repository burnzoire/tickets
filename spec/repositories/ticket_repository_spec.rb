require_relative '../../lib/tickets/repositories/ticket_repository.rb'

RSpec.describe TicketRepository do
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
    let(:id) { '436bf9b0-1147-4c0a-8439-6f79833bff5b' }

    subject { described_class.new.find(id) }

    it 'returns an Ticket' do
      expect(subject).to be_a_kind_of(Ticket)
    end

    it 'returns the correct id' do
      expect(subject._id).to eq(id)
    end
  end

  describe '#by_organization' do
    let(:org_id) { 101 }

    subject { described_class.new.by_organization(org_id) }

    it 'returns the correct number of tickets' do
      expect(subject.count).to eq(4)
    end

    it 'returns only tickets with the specified org id' do
      expect(subject).to all(have_attributes(organization_id: org_id))
    end
  end

  describe '#search' do
    let(:field) { 'subject' }
    let(:keyword) { 'A Drama in Iraq' }
    subject { described_class.new.search(field, keyword) }

    it 'returns a single result' do
      expect(subject.count).to eq(1)
    end

    it 'returns the ticket matching the search' do
      expect(subject.first.subject).to eq(keyword)
    end

    context 'with multiple hits' do
      let(:field) { 'tags' }
      let(:keyword) { 'Palau' }

      it 'returns 14 results' do
        expect(subject.count).to eq(14)
      end
    end
  end
end
