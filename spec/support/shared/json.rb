# TODO: use application/vnd.api+json and move to json_api
shared_context :json do
  header "Accept", "application/json"

  it "returns JSON" do
    do_request default_params
    expect(response_headers["Content-Type"]).to include("application/json")
  end
end
