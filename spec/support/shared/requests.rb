shared_examples_for :ok_request do
  example_request "has status 200" do
    expect(status).to eq 200
  end
end
