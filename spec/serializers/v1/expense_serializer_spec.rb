require "rails_helper"
require_relative "shared_examples/includes_owner_specs"

describe V1::ExpenseSerializer do
  let(:expense) { build_stubbed :expense }
  let(:serializer) { described_class.new model }
  let(:model) { expense }
  let(:root) { "expenses" }

  describe "links" do
    let(:links) { serializer.as_json[root].fetch :links }

    it_behaves_like :includes_owner do
      let(:model) { expense.tap { |f| f.owner = owner } }
      let(:owner) { build_stubbed :user }
    end
  end
end
