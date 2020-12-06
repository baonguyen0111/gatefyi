Rails.application.routes.draw do
  resources :feedbacks, only: [:index, :create] 
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"} 
  devise_scope :user do
	get 'users/sign_in', to: 'users/sessions#new', as: :new_user_session
	get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  namespace :admin do 
	resources :articles
	resources :feedbacks, only: [:index, :update]
  end
  resources :articles do 
	  resources :comments 
  end
  #resources :articles, :only => [:index, :show, :new, :create, :update]
  root :to => "static#index"
  get '/about' => 'static#aboutus', :as => :about
  get '/howto' => 'static#howto', :as=> :how
  get '/profile/:id' => 'profile#show', :as=> :profile
end
