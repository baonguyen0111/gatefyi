Rails.application.routes.draw do
  devise_for :admins
  resources :articles, :only => [:index, :show, :new, :create]
  root :to => "articles#index"
end
