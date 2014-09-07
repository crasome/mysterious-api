module SpecHelpers
  module JsonResponse
    def json_response
      JSON.parse!(response_body, symbolize_names: true)
    end
  end
end
