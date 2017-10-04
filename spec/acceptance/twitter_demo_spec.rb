require "acceptance_helper"

describe TwitterDemoApplication do
  describe 'search' do
    let(:query) { 'ruby' }
    let(:subject) { json_response[:data] }

    def do_request
      VCR.use_cassette('twitter/search') do
        get '/search', query: query
      end
    end

    it 'responds with ok' do
      do_request
      expect(last_response).to be_ok
    end

    it 'returns an array of tweets with matching search term' do
      do_request
      is_expected.to include hash_including(
        attributes: hash_including(
          text: /ruby/
        )
      )
    end

    context 'when no search term provided' do
      let(:subject) { json_response[:errors] }
      let(:query) { '' }

      it 'responds with bad request' do
        do_request
        expect(last_response).to be_bad_request
      end

      it 'provides error details' do
        do_request
        is_expected.to include hash_including(
          status: 400,
          title: 'Bad Request',
          detail: /query/
        )
      end
    end

    context 'when twitter returns an error' do
      let(:subject) { json_response[:errors] }

      before do
        allow(TWITTER_CLIENT).to receive(:search).and_raise(Twitter::Error::ClientError.new('client error', {}, 111))
      end

      it 'responds with appropriate code' do
        do_request
        expect(last_response.status).to eq 111
      end

      it 'provides error details' do
        do_request
        is_expected.to include hash_including(
          status: 111,
          title: 'ClientError',
          detail:'client error'
        )
      end
    end
  end
end
