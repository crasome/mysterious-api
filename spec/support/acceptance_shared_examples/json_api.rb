shared_examples_for :json_api do
  it "responds with application/vnd.api+json", document: false do
    do_request
    expect(response_headers["Content-Type"]).to include("application/vnd.api+json")
  end
end

shared_examples_for :json_api_collection do |name:|
  include_examples :json_api

  it "has resource name key", document: false do
    do_request
    expect(json_response).to have_key name
  end

  it "is represented as array", document: false do
    do_request
    expect(json_response[name]).to be_an Array
  end
end

shared_examples_for :json_api_resource do |name:|
  include_examples :json_api

  it "has resource name key", document: false do
    do_request
    expect(json_response).to have_key name
  end

  it "is represented as hash", document: false do
    do_request
    expect(json_response[name]).to be_a Hash
  end
end

shared_examples_for :json_compatible do
  describe "when pure JSON requested" do
    header "Accept", "application/json"

    it "responds with application/json", document: false do
      do_request
      if response_headers["Content-Type"].present?
        expect(response_headers["Content-Type"]).to include("application/json")
      end
    end
  end
end
