require "rails_helper"

describe User::Session do
  subject { described_class }

  describe "authenticate" do
    let(:user) { create :user }

    describe "when user identifier and password match" do
      it "assigns corresponding user" do
        session = subject.create! identifier: user.email, password: user.password
        expect(session.user).to eq user
      end
    end

    describe "when password does not match" do
      it "adds error" do
        session = subject.create identifier: user.email, password: "wrong_password"
        expect(session.errors).not_to be_empty
      end
    end
  end
end
