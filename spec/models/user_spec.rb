require "rails_helper"

describe User do
  describe "validity" do
    let(:user) { create :user }

    it "is invalid when invalid email provided" do
      user.email = "invalid_email"
      expect(user).not_to be_valid
    end

    it "is invalid when another user with same email exists" do
      expect(build_stubbed :user, email: user.email).not_to be_valid
    end
  end
end
