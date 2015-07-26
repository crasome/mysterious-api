require 'models/fyber/client'
require 'support/spec_helpers/fixtures'

describe Fyber::Client do
  include SpecHelpers::Fixtures

  subject { Fyber::Client.new api_key: 'abc' }

  describe '.get_offers' do
    let(:offers_json) { read_fixture 'fyber/offers.json' }

    it 'returns array of Offers' do
      allow(subject).to receive(:get).and_return offers_json
      expect(subject.get_offers uid: 123).to be_an Array
      expect(subject.get_offers uid: 123).to be_all do |offer|
        offer.is_a? Fyber::Offer
      end
    end
  end
end
