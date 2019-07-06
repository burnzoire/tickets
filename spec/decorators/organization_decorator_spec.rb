require_relative '../../lib/tickets/decorators/organization_decorator'
require_relative '../../lib/tickets/models/organization'
require_relative '../../lib/tickets/models/user'
require_relative '../../lib/tickets/models/ticket'

RSpec.describe OrganizationDecorator do

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

    let(:users) do
      Array.new(2) do |i|
        User.new(
          _id: i + 1,
          url: "foo.co/users/#{i + 1}",
          external_id: i,
          name: "Foo Bar #{'I' * (i + 1)}",
          alias: "Mr Bar #{'I' * (i + 1)}",
          created_at: '2017-04-01 10:00:00 +11',
          active: true,
          verified: true,
          shared: false,
          locale: 'en',
          timezone: '+11',
          last_login_at: '2019-06-30 13:00:00 +11',
          email: "foobar#{i}@foo.co",
          phone: '0410123456',
          signature: 'Hello World',
          organization_id: 1,
          tags: %w[foo bar],
          suspended: false,
          role: 'Tester'
        )
      end
    end

    let(:tickets) do
      Array.new(5) do |i|
        Ticket.new(
          _id: i + 1,
          url: "foo.co/tickets/#{i + 1}",
          external_id: i + 1,
          created_at: '2019-06-30 13:00:00 +11',
          type: 'whoopsie',
          subject: "problem ##{i + 1}",
          description: "This is problem number #{i + 1}",
          priority: 'high',
          status: 'open',
          submitter_id: 1,
          assignee_id: 2,
          organization_id: 1,
          tags: [],
          has_incidents: false,
          due_at: '2019-07-15 09:00:00 +11',
          via: 'rspec'
        )
      end
    end

    before do
      organization.users = users
      organization.tickets = tickets
    end

    subject { described_class.new(organization).to_s }

    it 'returns a string representation of the model' do
      expect(subject).to eq(
        <<~STR
          Organization #1
            name:          FooCo
            url:           foo.co/org.json
            domain_names:  foo.co, foo.com
            details:       Fake company
            created_at:    2017-04-01 10:00:00 +11
            external_id:   123
            tags:          foo, bar

            Users:
              _id    name          role          active verified
              1      Foo Bar I     Tester        true   true
              2      Foo Bar II    Tester        true   true

            Tickets:
              subject                   priority    status
              problem #1                high        open
              problem #2                high        open
              problem #3                high        open
              problem #4                high        open
              problem #5                high        open
        STR
      )
    end
  end
end
