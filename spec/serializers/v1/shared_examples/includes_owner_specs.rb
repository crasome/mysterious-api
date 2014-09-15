shared_examples_for :includes_owner do
  it "is included as id" do
    expect(serializer.as_json[root]).to include links: include(owner: owner.id)
  end
end
