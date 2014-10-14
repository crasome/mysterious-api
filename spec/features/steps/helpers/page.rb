module StepHelpers::Page
  def be_on(path)
    expect(URI.parse(current_url).path).to eq path
  end
end
