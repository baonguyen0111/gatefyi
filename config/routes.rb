Rails.application.routes.draw do
  devise_for :admins, controllers: {omniauth_callbacks: "admins/omniauth_callbacks"}
  devise_scope :admin do
	get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
	get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
  namespace :admin do 
	resources :articles
  end


  resources :articles, :only => [:index, :show, :new, :create, :update]
  root :to => "articles#index"
end
