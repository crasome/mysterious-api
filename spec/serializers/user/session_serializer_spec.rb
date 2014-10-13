require "rails_helper"

describe User::SessionSerializer do
  let(:session) { build_stubbed :session }
  let(:serializer) { described_class.new session }
  let(:root) { "sessions" }

  describe "links" do
    let(:links) { serializer.as_json[root].fetch :links }

    it "includes user" do
      expect(links).to include :user => include(:email, :id)
    end
  end
end
