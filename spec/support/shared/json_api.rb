shared_examples_for :json_api_collection do
  it "has resource name key" do
    do_request default_params
    expect(json_response).to have_key resource_name
  end

  it "is represented as array" do
    do_request default_params
    expect(json_response[resource_name]).to be_an Array
  end
end

shared_examples_for :json_api_resource do
  it "has resource name key" do
    do_request default_params
    expect(json_response).to have_key resource_name
  end

  it "is represented as hash" do
    do_request default_params
    expect(json_response[resource_name]).to be_a Hash
  end
end
