Rails.application.routes.draw do
  api_version(:module => "V1", :header => {:name => "API-VERSION", :value => "v1"}) do
    resources :users, only: [:index, :show, :update]
    resources :documents, only: [:index, :show, :update, :create]
    resources :folders, only: [:index, :show, :update, :create]
  end

  mount Raddocs::App => "/docs"
end
