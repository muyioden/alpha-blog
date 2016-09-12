Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'welcome/home', to: "welcome#home"
  get 'welcome/about', to: "welcome#about"

  # Pages section
  root "pages#home"
  get 'about', to: "pages#about"

  # Routes for Article Model
  resources :articles

  #Routes for User Model
  get 'signup', to: "users#new"
  resources :users, except: [:new]

  #Routes for Sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  #Routes for Categories
  resources :categories, except: [:destroy]

end