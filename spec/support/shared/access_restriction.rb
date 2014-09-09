shared_context :restricted_request do |allowed_roles:nil, rejected_roles:nil|
  all_roles = %i[common guest admin owner]

  allowed_roles ||= all_roles - rejected_roles
  rejected_roles ||= all_roles - allowed_roles

  let(:resource) { nil }


  describe "allow access to resource" do
    allowed_roles.each do |role|
      specify "for #{role} role" do
        http_authorization_header role_to_user(role)

        do_request default_params
        expect(status).to be_between 200, 299
      end
    end
  end

  describe "restricts access to resource" do
    rejected_roles.each do |role|
      specify "for #{role} role" do
        http_authorization_header role_to_user(role)

        do_request default_params
        expect(status).to eq 403
      end
    end
  end

  private

  def role_to_user(role)
    # HACK for user owneship
    return resource if :owner == role && resource.is_a?(User)
    create(:user, role, resource: resource)
  end

  def http_authorization_header(user)
    header "AUTHORIZATION", ActionController::HttpAuthentication::Basic.encode_credentials(
      user.email, user.password
    )
  end
end
