module TwitterApi
  module Requests
    class Search
      def initialize(params, client:)
        @query = params[:query]
        @client = client
        @limit = params[:limit].presence || 10
      end

      def validate!
        raise TwitterApi::ArgumentError, 'Parameter is missing: query' if query.blank?
      end

      def perform
        client.search(query, result_type: "recent").take(limit)
      end

      private

      attr_reader :query, :client, :limit
    end
  end
end
