shared_examples_for :authentication_required do
  describe "anonimus user" do
    before { sign_out }

    it "is disallowed to access resource", document: false do
      do_request
      expect(status).to eq 401
    end
  end

  describe "user with invalid credentials", document: false do
    let(:api_user) { build :user }

    it "is disallowed to access resource" do
      do_request
      expect(status).to eq 401
    end
  end
end

shared_examples_for :publicly_available do
  describe "anonimus user" do
    before { sign_out }

    it "is allowed to access resource", document: false do
      do_request
      expect(status).not_to eq 401
    end
  end
end
