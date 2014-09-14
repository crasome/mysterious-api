shared_examples_for :publicly_accessible_request do
  example_request "do not expose private information" do
    expect(response_body).not_to include "password"
  end
end
