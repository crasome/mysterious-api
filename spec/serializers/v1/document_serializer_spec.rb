require "rails_helper"
require_relative "shared_examples/includes_owner_specs"

describe V1::DocumentSerializer do
  let(:document) { build_stubbed :document }
  let(:serializer) { described_class.new model }
  let(:model) { document }
  let(:root) { "documents" }

  describe "links" do
    let(:links) { serializer.as_json[root].fetch :links }

    it_behaves_like :includes_owner do
      let(:model) { document.tap { |f| f.owner = owner } }
      let(:owner) { build_stubbed :user }
    end
  end
end
