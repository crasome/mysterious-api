require "rails_helper"
require_relative "shared_examples/includes_owner_specs"

describe V1::FolderSerializer do
  let(:serializer) { described_class.new model }
  let(:model) { build_stubbed :folder, owner: owner }
  let(:owner) { build_stubbed :user }
  let(:root) { "folders" }

  it_behaves_like :includes_owner
end
