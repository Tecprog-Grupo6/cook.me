Rails.application.routes.draw do

  get 'perfil/show'

  devise_for :users, :controllers => {registrations: 'users/registrations'}
  resources :users, only: [ :show, :edit, :update, ]
  resources :recipes

  root to: "home#index"
  get '/' => 'home#index'
  get '/buscar' => 'search#index'
  post '/buscar' => 'search#show_results'

  as :user do
    get '/login', to: 'users/sessions#new'
    post '/login', to: 'users/sessions#create'
    get '/logout', to: 'users/sessions#destroy'
    get '/perfil/senha/recuperar', to: 'users/passwords#new'
    get '/perfil/senha/editar', to: 'users/passwords#edit'
    patch '/perfil/senha/atualizar',to: 'users/passwords#update'
    put '/perfil/senha/atualizar', to: 'users/passwords#update'
    post '/perfil/senha/criar', to: 'users/passwords#create'
    get '/perfil/cancelar', to: 'users/registrations#cancel'
    get '/perfil/criar', to: 'users/registrations#new'
    get '/perfil/editar', to: 'users/registrations#edit'
    patch '/perfil/atualizar', to: 'users/registrations#update'
    put '/perfil/atualizar', to: 'users/registrations#update'
    delete '/perfil/excluir', to: 'users/registrations#destroy'
    post '/perfil/criar', to: 'users/registrations#create'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
