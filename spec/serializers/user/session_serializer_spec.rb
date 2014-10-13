require "rails_helper"
require_relative "shared_examples/includes_owner_specs"

describe User::SessionSerializer do
  let(:session) { build_stubbed :session }
  let(:serializer) { described_class.new model }
  let(:model) { session }
  let(:root) { "sessions" }

  describe "links" do
    let(:links) { serializer.as_json[root].fetch :links }

    it "includes user" do
      expect(links).to include :user => include(:email, :id)
    end
  end
end
