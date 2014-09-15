shared_examples_for :restricted_request do |allowed_roles:nil, rejected_roles:nil|
  all_roles = %i[registered guest admin owner]

  allowed_roles ||= all_roles - rejected_roles
  rejected_roles ||= all_roles - allowed_roles

  let(:resource) { nil }

  all_roles.each do |role|
    describe "#{role} user" do
      let(:api_user) { user_with_role role }

      example_request "is allowed to do the request" do
        expect(status).to be_between 200, 299
      end if allowed_roles.include? role

      example_request "is not allowed to do the request" do
        expect(status).to eq 403
      end if rejected_roles.include? role
    end
  end

  private

  def user_with_role(role)
    create :user, role, resource: resource
  end
end
