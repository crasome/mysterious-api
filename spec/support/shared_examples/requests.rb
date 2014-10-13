# Get collection
# vars: resource, respond_with
shared_examples_for :get_collection_request do |name:|
  before { resource }
  before { do_request }
  let(:respond_with) { {} }

  it "has status :ok" do
    expect(response).to have_http_status :ok
  end

  it "responds with a collection" do
    expect(json_response[name]).to be_a Array
  end

  it "includes resource object" do
    expect(json_response[name]).to include include(id: resource.id)
    expect(json_response[name]).to include include(respond_with)
  end
end

# Get resource
# vars: resource, respond_with
shared_examples_for :get_resource_request do |name:|
  before { resource }
  before { do_request }
  let(:respond_with) { {} }

  it "has status :ok" do
    expect(response).to have_http_status :ok
  end

  it "responds with resource object" do
    expect(json_response[name]).to include id: resource.id
    expect(json_response[name]).to include respond_with
  end
end

# Update resource
# vars: resource, respond_with, changes
shared_examples_for :update_resource_request do |name:|
  before { resource }
  before { do_request }
  let(:respond_with) { changes }

  it "has status :ok" do
    expect(response).to have_http_status :ok
  end

  it "updates attributes" do
    resource.reload
    changes.each do |attribute, value|
      expect(resource.public_send attribute).to eq value
    end
  end

  it "responds with updated object" do
    expect(json_response[name]).to include id: resource.id
    expect(json_response[name]).to include respond_with
  end
end

# Create resource
# vars: resource_scope, respond_with
shared_examples_for :create_resource_request do |name:, persisted: true|
  before { do_request }
  let(:respond_with) { {} }

  it "has status :created" do
    expect(response).to have_http_status :created
  end

  it "responds with created object" do
    expect(json_response[name]).to have_key :id if persisted
    expect(json_response[name]).to include respond_with
  end

  if persisted
    it "responds with location header" do
      expect(response.headers).to include "Location" => /#{name}\/\d+/
    end

    it "adds new resource to the scope" do
      expect(resource_scope.where(id: json_response[name][:id]).take).to be_persisted
    end
  end
end

# Errors
shared_examples_for :error_resource do
  before { do_request }
  let(:name) { :errors }
  let(:respond_with) { {} }

  it "has status :unprocessable_entity" do
    expect(response).to have_http_status :unprocessable_entity
  end

  it "responds with error object" do
    expect(json_response[name]).to include respond_with
    expect(json_response[name]).to include title: /error/i
  end
end
