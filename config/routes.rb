Rails.application.routes.draw do
  resource :login

  get 'sessions/create'
  get 'static_pages/homepage', as: 'homepage'
  delete 'sessions/destroy'

  resources :users
  resources :forms
  resources :data_entries

  root 'forms#index'
end
