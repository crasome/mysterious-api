require "rails_helper"
require_relative "shared_examples/includes_owner_specs"

describe V1::FolderSerializer do
  let(:folder) { build_stubbed :folder }
  let(:serializer) { described_class.new model }
  let(:model) { folder }
  let(:root) { "folders" }

  describe "links" do
    let(:links) { serializer.as_json[root].fetch :links }

    it_behaves_like :includes_owner do
      let(:model) { folder.tap { |f| f.owner = owner } }
      let(:owner) { build_stubbed :user }
    end

    describe "documents" do
      let(:documents) { [document] }
      let(:document) { build_stubbed :document }
      before { allow(folder).to receive(:documents).and_return documents }

      it "are included as ids" do
        expect(links).to include documents: [document.id]
      end
    end
  end
end
