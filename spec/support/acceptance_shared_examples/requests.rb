shared_examples_for :ok_request do
  example_request "has status 200" do
    expect(status).to eq 200
  end
end

shared_examples_for :created_request do
  example_request "has status 201" do
    expect(status).to eq 201
  end
end

shared_examples_for :invalid_attributes_request do
  example_request "has status 422" do
    expect(status).to eq 422
  end
end
