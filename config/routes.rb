Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'projects#index'

  resources :users, only: %i[new create] do
    collection do
      get  :login
      post :create_session
      get  :logout
    end
  end

  resources :projects, only: %i[new create index show] do
    resources :parameters_comparisons, only: [] do
      collection do
        get :compare
      end
      member do
        post :skip
        post :confirm
      end
    end
  end

  resources :expert_requests, only: %i[show update] do

  end

  resources :project_parameters, only: %i[show update] do
    member do
      post :skip
    end
  end
end
