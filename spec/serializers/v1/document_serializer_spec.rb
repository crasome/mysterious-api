require "rails_helper"
require_relative "shared_examples/includes_owner_specs"

describe V1::DocumentSerializer do
  let(:serializer) { described_class.new model }
  let(:model) { build_stubbed :document, owner: owner }
  let(:owner) { build_stubbed :user }
  let(:root) { "documents" }

  include_examples :includes_owner
end
