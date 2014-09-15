require "rails_helper"

describe User do
  let(:user) { create :user }

  describe "validity" do
    it "is invalid when invalid email provided" do
      user.email = "invalid_email"
      expect(user).not_to be_valid
    end

    it "is invalid when another user with same email exists" do
      expect(build_stubbed :user, email: user.email).not_to be_valid
    end
  end
end
