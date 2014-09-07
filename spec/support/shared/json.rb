# TODO: use application/vnd.api+json and move to json_api
shared_context :json do
  header "Accept", "application/json"

  example_request "returns JSON" do
    expect(response_headers["Content-Type"]).to include("application/json")
  end
end
