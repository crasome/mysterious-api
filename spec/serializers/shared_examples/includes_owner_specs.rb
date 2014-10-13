shared_examples_for :includes_owner do
  it "is included as id" do
    expect(links).to include owner: owner.id
  end
end
