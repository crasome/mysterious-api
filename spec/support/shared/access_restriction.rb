shared_context :restricted_request do |allowed_roles:nil, rejected_roles:nil|
  all_roles = %i[registered guest admin owner]

  allowed_roles ||= all_roles - rejected_roles
  rejected_roles ||= all_roles - allowed_roles

  let(:resource) { nil }


  describe "allow access to resource" do
    allowed_roles.each do |role|
      specify "for #{role} role" do
        sign_in user_with_role role

        do_request default_params
        expect(status).to be_between 200, 299
      end
    end
  end

  describe "restricts access to resource" do
    rejected_roles.each do |role|
      specify "for #{role} role" do
        sign_in user_with_role role

        do_request default_params
        expect(status).to eq 403
      end
    end
  end

  private

  def user_with_role(role)
    create :user, role, resource: resource
  end
end
