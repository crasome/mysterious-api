require "acceptance_helper"
require 'rspec_api_documentation/dsl'

resource "Users" do
  get "/users" do
    include_context :json

    it_behaves_like :ok_request
    it_behaves_like :public_request
    it_behaves_like :json_api_collection do
      let(:resource_name) { :users }
    end

    it "includes users" do
      users = create_list :user, 2

      do_request
      users.each do |user|
        expect(json_response[:users]).to include include(
          email: user.email
        )
      end
    end
  end

  get "/users/:id" do
    include_context :json
    let(:id) { user.id }
    let!(:user) { create :user }

    it_behaves_like :ok_request
    it_behaves_like :public_request
    it_behaves_like :json_api_resource do
      let(:resource_name) { :users }
    end

    example_request "returns user information" do
      expect(json_response[:users]).to include(
        email: user.email,
        id: user.id
      )
    end
  end

  put "/users/:id" do
    include_context :json
    let(:id) { user.id }
    let!(:user) { create :user }

    parameter :users, "single top-level resource object"
    def default_params
      {
        users: {
          id: user.id,
          email: "alice@example.com"
        }
      }
    end

    it_behaves_like :ok_request
    it_behaves_like :public_request
    it_behaves_like :json_api_resource do
      let(:resource_name) { :users }
    end

    it "updates user attributes" do
      do_request users: {
        id: user.id,
        email: "alice@example.com"
      }

      user.reload
      expect(user.email).to eq "alice@example.com"
    end

    it "returns user information" do
      do_request default_params

      user.reload
      expect(json_response[:users]).to include(
        email: user.email,
        id: user.id
      )
    end

    describe "when validation error occurs" do
      def default_params
        {
          users: {
            id: user.id,
            email: "invalid_email"
          }
        }
      end
      it_behaves_like :invalid_attributes_request
      it_behaves_like :json_api_resource do
        let(:resource_name) { :errors }
      end

      it "returns error resource" do
        do_request default_params

        expect(json_response[:errors]).to include(
          title: /error/,
          detail: /email/
        )
      end
    end
  end

  def default_params
    {}
  end
end
