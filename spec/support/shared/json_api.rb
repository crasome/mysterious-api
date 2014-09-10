shared_examples_for :json_api_collection do
  example_request "has resource name key" do
    expect(json_response).to have_key resource_name
  end

  example_request "is represented as array" do
    expect(json_response[resource_name]).to be_an Array
  end
end

shared_examples_for :json_api_resource do
  example_request "has resource name key" do
    expect(json_response).to have_key resource_name
  end

  example_request "is represented as hash" do
    expect(json_response[resource_name]).to be_a Hash
  end
end
