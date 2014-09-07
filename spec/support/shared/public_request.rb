shared_examples_for :public_request do
  it "dont expose private information" do
    do_request default_params
    expect(response_body).not_to include "password"
  end
end
