require_relative '../../lib/tickets/decorators/user_decorator'
require_relative '../../lib/tickets/models/organization'
require_relative '../../lib/tickets/models/user'
require_relative '../../lib/tickets/models/ticket'

RSpec.describe UserDecorator do
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

    let(:user) do
      User.new(
        _id: 1,
        url: 'foo.co/users/1',
        external_id: 1,
        name: 'Foo Bar',
        alias: 'Mr Bar',
        created_at: '2017-04-01 10:00:00 +11',
        active: true,
        verified: true,
        shared: false,
        locale: 'en',
        timezone: '+11',
        last_login_at: '2019-06-30 13:00:00 +11',
        email: 'foobar@foo.co',
        phone: '0410123456',
        signature: 'Hello World',
        organization_id: 1,
        tags: %w[foo bar],
        suspended: false,
        role: 'Tester'
      )
    end

    let(:assigned_tickets) do
      Array.new(2) do |i|
        Ticket.new(
          _id: i,
          url: "foo.co/tickets/#{i + 1}",
          external_id: i + 1,
          created_at: '2019-06-30 13:00:00 +11',
          type: 'whoopsie',
          subject: "Problem ##{i + 1}",
          description: 'This is a problem',
          priority: 'high',
          status: 'open',
          submitter_id: 2,
          assignee_id: 1,
          organization_id: 1,
          tags: %w[angry ombudsman],
          has_incidents: false,
          due_at: '2019-07-15 09:00:00 +11',
          via: 'rspec'
        )
      end
    end

    let(:submitted_tickets) do
      [
        Ticket.new(
          _id: 3,
          url: 'foo.co/tickets/3',
          external_id: 3,
          created_at: '2019-06-30 13:00:00 +11',
          type: 'whoopsie',
          subject: 'Problem #3',
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
      ]
    end

    before do
      user.submitted_tickets = submitted_tickets
      user.assigned_tickets = assigned_tickets
      user.organization = organization
    end

    subject { described_class.new(user).to_s }

    it 'returns a string representation of the model' do
      expect(subject).to eq(
        <<~STR
          User #1
            name:          Foo Bar
            url:           foo.co/users/1
            organization:  FooCo
            created_at:    2017-04-01 10:00:00 +11
            tags:          foo, bar

            Submitted Tickets:
              subject                                      priority    status
              Problem #3                                   high        open

            Assigned Tickets:
              subject                                      priority    status
              Problem #1                                   high        open
              Problem #2                                   high        open
        STR
      )
    end
  end
end
