require "rails_helper"

describe User do
  let(:user) { create :user }

  describe "validity" do
    it "is invalid when invalid email provided" do
      expect(user.update_attributes email: "invalid_email").to be_falsey
    end
  end
end
