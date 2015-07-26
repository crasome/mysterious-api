Rails.application.routes.draw do
  root :to => "pages#welcome"

  api_version(:module => "V1", :header => {:name => "API-VERSION", :value => "v1"}) do
  end

  mount Raddocs::App => "/docs"

  # Angular-only routes
  get :offers, as: :offers, to: 'pages#welcome'

  # Catch-all route for HTML requests: renders the AngularJS application.
  scope constraints: { format: /html/ } do
    get '(*any)', to: 'pages#welcome'
  end
end
