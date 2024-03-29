require_relative '../../lib/tickets/models/organization.rb'

RSpec.describe Organization do
  let(:params) do
    {
      _id: 101,
      url: 'http://initech.zendesk.com/api/v2/organizations/101.json',
      external_id: '9270ed79-35eb-4a38-a46f-35725197ea8d',
      name: 'Enthaze',
      domain_names: [
        'kage.com',
        'ecratic.com',
        'endipin.com',
        'zentix.com'
      ],
      created_at: '2016-05-21T11:10:28 -10:00',
      details: 'MegaCorp',
      shared_tickets: false,
      tags: [
        'Fulton',
        'West',
        'Rodriguez',
        'Farley'
      ]
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

    it 'returns a summary of the organization' do
      expect(subject).to eq('Organization #101 Enthaze')
    end
  end
end
