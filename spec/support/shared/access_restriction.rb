shared_examples_for :restricted_request do
  let(:resource) { nil }

  let(:all_roles) { %i[common guest admin owner] }

  let(:allowed_roles) { all_roles - rejected_roles }
  let(:rejected_roles) { all_roles - allowed_roles }

  it "allows access for allowed_users" do
    Array(allowed_roles).each do |role|
      do_restricted_request role_to_user(role)
      expect(status).to be_between(200, 299), "#{role} role should be allowed to access #{resource}"
    end
  end

  it "restrict access for rejected_roles" do
    Array(rejected_roles).each do |role|
      do_restricted_request role_to_user(role)
      expect(status).to eq(403), "#{role} role should be rejected to access #{resource}"
    end
  end

  private

  def role_to_user(role)
    # HACK for user owneship
    return resource if :owner == role && resource.is_a?(User)
    create(:user, role, resource: resource)
  end

  def do_restricted_request(user)
    do_request default_params.merge 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
      user.email, user.password
    )
  end
end
