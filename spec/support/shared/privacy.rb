shared_examples_for "respect privacy in response" do
  it "dont expose private information" do
    expect(response_body).not_to include "password"
  end
end
