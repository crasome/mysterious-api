shared_examples_for :public_request do
  example_request "dont expose private information" do
    expect(response_body).not_to include "password"
  end
end
