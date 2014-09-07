shared_examples_for :ok_request do
  it "has status 200" do
    do_request default_params
    expect(status).to eq 200
  end
end
