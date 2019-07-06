require_relative '../../lib/tickets/models/user.rb'

RSpec.describe User do
  let(:params) do
    {
      _id: 1,
      url: 'http://initech.zendesk.com/api/v2/users/1.json',
      external_id: '74341f74-9c79-49d5-9611-87ef9b6eb75f',
      name: 'Francisca Rasmussen',
      alias: 'Miss Coffey',
      created_at: '2016-04-15T05:19:46 -10:00',
      active: true,
      verified: true,
      shared: false,
      locale: 'en-AU',
      timezone: 'Sri Lanka',
      last_login_at: '2013-08-04T01:03:27 -10:00',
      email: 'coffeyrasmussen@flotonic.com',
      phone: '8335-422-718',
      signature: 'Don\'t Worry Be Happy!',
      organization_id: 119,
      tags: [
        'Springville',
        'Sutton',
        'Hartsville/Hartley',
        'Diaperville'
      ],
      suspended: true,
      role: 'admin'
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

    it 'returns a summary of the user' do
      expect(subject).to eq('User #1 Francisca Rasmussen')
    end
  end
end
