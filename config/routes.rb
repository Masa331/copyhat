Rails.application.routes.draw do
  resource :login

  get 'sessions/create'
  delete 'sessions/destroy'

  resources :users
  resources :forms
  resources :data_entries

  root 'static_pages#homepage'
end
