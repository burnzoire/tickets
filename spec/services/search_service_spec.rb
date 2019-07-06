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

  describe '#search_users' do
    subject { described_class.new.search_users('name', 'Dennis Hopkins') }

    it 'returns a user' do
      expect(subject.first).to have_attributes(
        _id: 60,
        name: 'Dennis Hopkins'
      )
    end

    it 'includes the correct associated organization' do
      expect(subject.first.organization.name).to eq('Zolarex')
    end

    it 'includes the submitted tickets for the user' do
      expect(subject.first.submitted_tickets).to all(
        have_attributes(submitter_id: 60)
      )
    end

    it 'includes the assigned tickets for the user' do
      expect(subject.first.assigned_tickets).to all(
        have_attributes(assignee_id: 60)
      )
    end
  end

  describe '#search_tickets' do
    subject { described_class.new.search_tickets('subject', 'A Drama in Iraq') }

    it 'returns a ticket' do
      expect(subject.first).to have_attributes(
        _id: '25c518a8-4bd9-435a-9442-db4202ec1da4',
        subject: 'A Drama in Iraq'
      )
    end

    it 'includes the correct associated organization' do
      expect(subject.first.organization.name).to eq('Plasmos')
    end

    it 'includes the submitter' do
      expect(subject.first.submitter.name).to eq('Dennis Hopkins')
    end

    it 'includes the assignee' do
      expect(subject.first.assignee.name).to eq('Valentine Ashley')
    end
  end
end
