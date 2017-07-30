Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  root to: 'public/request_offs#index'
  get '/admin', to: 'admin/dashboard#index'

  scope module: :public do
    resources :request_offs do
      member do
        get :cancel
      end
    end
    get 'user_profile' => 'dashboard#user_profile'
    post 'update_password_user' => 'dashboard#update_password_user'
  end

  namespace :admin do
    resources :dashboard
    resources :users
    resources :request_offs do
			member do
				get :accept
				get :reject
      end
    end
    resources :departments
    get 'print' => 'request_offs#print'
    post 'upload' => 'request_offs#upload'
  end
end
