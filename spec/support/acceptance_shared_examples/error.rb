shared_context :error do
  response_field :errors,  "Errors object"
  response_field :title,   "Summary of the problem",      scope: :errors
  response_field :detail,  "Explanation of the problem",  scope: :errors
  it_behaves_like :json_compatible
  it_behaves_like :json_api_resource, name: :errors
end
