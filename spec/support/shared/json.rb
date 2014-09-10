shared_context :json do
  header "Accept", "application/vnd.api+json"
  header "Content-Type", "application/vnd.api+json"

  example_request "returns application/vnd.api+json" do
    expect(response_headers["Content-Type"]).to include("application/vnd.api+json")
  end

  describe "when requesting pure JSON" do
    header "Accept", "application/json"

    example_request "responds with JSON" do
      expect(response_headers["Content-Type"]).to include("application/json")
    end
  end
end
