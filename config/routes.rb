Rails.application.routes.draw do
  root :to => "pages#welcome"

  api_version(:module => "V1", :header => {:name => "API-VERSION", :value => "v1"}) do
    resources :users, only: [:show, :create]
    resources :sessions, only: [:create]
    resources :expenses, only: [:index, :show, :update, :create]
  end

  mount Raddocs::App => "/docs"

  # Catch-all route for HTML requests: renders the AngularJS application.
  scope constraints: { format: /html/ } do
    get '(*any)', to: 'pages#welcome'
  end
end
