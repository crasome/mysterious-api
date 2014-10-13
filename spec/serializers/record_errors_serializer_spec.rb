require "rails_helper"

describe RecordErrorsSerializer do
  let(:serializer) { described_class.new model }
  let(:model) { build_stubbed :user, :invalid }
  let(:root) { "errors" }

  before { expect(model).to be_invalid }

  it "has error title" do
    expect(serializer.as_json[root]).to include title: /error/i
  end

  it "includes error detail" do
    expect(serializer.as_json[root]).to include detail: /email/
  end

  it "has unprocessable_error status code" do
    expect(serializer.as_json[root][:status]).to eq 422
  end
end
