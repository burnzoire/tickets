require_relative '../../lib/tickets/services/search_service.rb'

RSpec.describe SearchService do
  describe '#search_organizations' do
    subject { described_class.new.search_organizations('name', 'Bitrex') }

    it 'returns an organization' do
      expect(subject.first).to have_attributes(
        _id: 124,
        name: 'Bitrex'
      )
    end

    it 'includes the correct number or associated users' do
      expect(subject.first.users.count).to eq(5)
    end

    it 'includes all associated users' do
      expect(subject.first.users).to all(
        have_attributes(organization_id: 124)
      )
    end

    it 'includes the correct number or associated tickets' do
      expect(subject.first.tickets.count).to eq(10)
    end

    it 'includes all associated tickets' do
      expect(subject.first.tickets).to all(
        have_attributes(organization_id: 124)
      )
    end
  end
end
