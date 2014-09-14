shared_context :json do
  example_request "responds with application/vnd.api+json" do
    expect(response_headers["Content-Type"]).to include("application/vnd.api+json")
  end

  describe "when pure JSON requested" do
    header "Accept", "application/json"

    example_request "responds with application/json" do
      expect(response_headers["Content-Type"]).to include("application/json")
    end
  end
end
