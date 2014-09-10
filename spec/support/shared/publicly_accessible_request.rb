shared_examples_for :publicly_accessible_request do
  it "do not expose private information" do
    do_request default_params
    expect(response_body).not_to include "password"
  end
end
