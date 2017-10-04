require 'sinatra/base'
require 'twitter'
require 'json'
require 'facets'
require_relative 'config'
require_relative 'twitter_api/requests/search'
require_relative 'twitter_api/errors'

class TwitterDemoApplication < Sinatra::Application
  get '/search' do
    content_type :json
    request = TwitterApi::Requests::Search.new(params, client: TWITTER_CLIENT)
    request.validate!
    tweets = request.perform

    { data: present(tweets) }.to_json
  end

  error TwitterApi::ArgumentError do |error|
    status 400
    { errors: present_error(error, status: 400) }.to_json
  end

  private

  # TODO: use serializers
  def present(collection)
    collection.map do |item|
      present_tweet(item)
    end
  end

  def present_tweet(tweet)
    {
      id: tweet.id,
      type: 'tweet',
      attributes: {
        text: tweet.text
      }
    }
  end

  def present_error(error, status:)
    [
      {
        status: status,
        title: error.title,
        detail: error.message
      }
    ]
  end
end
