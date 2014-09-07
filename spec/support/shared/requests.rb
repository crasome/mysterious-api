shared_examples_for :ok_request do
  it "has status 200" do
    do_request default_params
    expect(status).to eq 200
  end
end

shared_examples_for :invalid_attributes_request do
  it "has status 422" do
    do_request default_params
    expect(status).to eq 422
  end
end
