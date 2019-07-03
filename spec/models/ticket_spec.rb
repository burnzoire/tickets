require_relative '../../lib/tickets/models/ticket.rb'

RSpec.describe Ticket do
  let(:params) do
    {
      '_id' => '436bf9b0-1147-4c0a-8439-6f79833bff5b',
      'url' => 'http://initech.zendesk.com/api/v2/tickets/436bf9b0-1147-4c0a-8439-6f79833bff5b.json',
      'external_id' => '9210cdc9-4bee-485f-a078-35396cd74063',
      'created_at' => '2016-04-28T11:19:34 -10:00',
      'type' => 'incident',
      'subject' => 'A Catastrophe in Korea (North)',
      'description' => 'Nostrud ad sit velit cupidatat laboris ipsum nisi amet laboris ex exercitation amet et ' \
                       'proident. Ipsum fugiat aute dolore tempor nostrud velit ipsum.',
      'priority' => 'high',
      'status' => 'pending',
      'submitter_id' => 38,
      'assignee_id' => 24,
      'organization_id' => 116,
      'tags' => [
        'Ohio',
        'Pennsylvania',
        'American Samoa',
        'Northern Mariana Islands'
      ],
      'has_incidents' => false,
      'due_at' => '2016-07-31T02:37:50 -10:00',
      'via' => 'web'
    }
  end

  describe 'initialize' do
    subject { described_class.new(params) }

    it 'has the expected attributes' do
      expect(subject).to have_attributes(params)
    end
  end

  describe 'to_s' do
    subject { described_class.new(params).to_s }

    it 'returns a summary of the ticket' do
      expect(subject).to eq('Ticket #436bf9b0-1147-4c0a-8439-6f79833bff5b A Catastrophe in Korea (North) (pending)')
    end
  end

end
