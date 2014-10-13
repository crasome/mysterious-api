require "rails_helper"

describe User::Login do
  subject { described_class }

  describe ".authenticate" do
    let(:user) { create :user }

    describe "when user identifier and password match" do
      it "returns corresponding user" do
        authenticated_user = subject.authenticate user.email, user.password
        expect(authenticated_user).to eq user
      end
    end

    describe "when password does not match" do
      it "raises AuthorizationFailedError" do
        expect do
          subject.authenticate user.email, "wrong_password"
        end.to raise_error(described_class::AuthorizationFailedError)
      end
    end
  end
end
