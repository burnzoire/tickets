require_relative '../../lib/tickets/decorators/ticket_decorator'
require_relative '../../lib/tickets/models/organization'
require_relative '../../lib/tickets/models/user'
require_relative '../../lib/tickets/models/ticket'

RSpec.describe TicketDecorator do

  describe '#to_s' do
    let(:organization) do
      Organization.new(
        _id: 1,
        url: 'foo.co/org.json',
        name: 'FooCo',
        external_id: 123,
        domain_names: ['foo.co', 'foo.com'],
        created_at: '2017-04-01 10:00:00 +11',
        details: 'Fake company',
        shared_tickets: false,
        tags: %w[foo bar]
      )
    end

    let(:submitter) do
      User.new(
        _id: 1,
        url: 'foo.co/users/1',
        external_id: 1,
        name: 'Foo Bar I',
        alias: 'Mr Bar I',
        created_at: '2017-04-01 10:00:00 +11',
        active: true,
        verified: true,
        shared: false,
        locale: 'en',
        timezone: '+11',
        last_login_at: '2019-06-30 13:00:00 +11',
        email: 'foobar1@foo.co',
        phone: '0410123456',
        signature: 'Hello World',
        organization_id: 1,
        tags: %w[foo bar],
        suspended: false,
        role: 'Tester'
      )
    end

    let(:assignee) do
      User.new(
        _id: 2,
        url: 'foo.co/users/2',
        external_id: 2,
        name: 'Foo Bar II',
        alias: 'Mr Bar II',
        created_at: '2017-04-01 10:00:00 +11',
        active: true,
        verified: true,
        shared: false,
        locale: 'en',
        timezone: '+11',
        last_login_at: '2019-06-30 13:00:00 +11',
        email: "foobar2@foo.co",
        phone: '0410123456',
        signature: 'Hello World',
        organization_id: 1,
        tags: %w[foo bar],
        suspended: false,
        role: 'Tester'
      )
    end

    let(:ticket) do
      Ticket.new(
        _id: 1,
        url: 'foo.co/tickets/1',
        external_id: 1,
        created_at: '2019-06-30 13:00:00 +11',
        type: 'whoopsie',
        subject: 'A Problem in Box Hill South',
        description: 'This is a problem',
        priority: 'high',
        status: 'open',
        submitter_id: 1,
        assignee_id: 2,
        organization_id: 1,
        tags: %w[angry ombudsman],
        has_incidents: false,
        due_at: '2019-07-15 09:00:00 +11',
        via: 'rspec'
      )
    end

    before do
      ticket.submitter = submitter
      ticket.assignee = assignee
      ticket.organization = organization
    end

    subject { described_class.new(ticket).to_s }

    it 'returns a string representation of the model' do
      expect(subject).to eq(
        <<~STR
          Ticket #1:
            subject:       A Problem in Box Hill South
            type:          whoopsie
            priority:      high
            status:        open
            description    This is a problem
            submitted by:  Foo Bar I
            assigned to    Foo Bar II
            organization:  FooCo
            url:           foo.co/tickets/1
            created_at:    2019-06-30 13:00:00 +11
            tags:          angry, ombudsman
        STR
      )
    end
  end
end
