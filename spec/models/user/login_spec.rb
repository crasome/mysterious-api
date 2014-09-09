require "rails_helper"

describe User::Login do
  subject { described_class }

  describe ".authenticate" do
    describe "when user identifier and password match" do
      let(:user) { create :user }

      it "returns corresponding user" do
        authenticated_user = subject.authenticate user.email, user.password
        expect(authenticated_user).to eq user
      end
    end

    describe "when password does not match" do
      let(:user) { create :user }

      it "raises AuthorizationFailedError" do
        expect do
          subject.authenticate user.email, "wrong_password"
        end.to raise_error(described_class::AuthorizationFailedError)
      end
    end

    describe "when user does not exists" do
      let(:user) { build_stubbed :user }

      it "raises AuthorizationFailedError" do
        expect do
          subject.authenticate user.email, user.password
        end.to raise_error(described_class::AuthorizationFailedError)
      end
    end

  end
end
