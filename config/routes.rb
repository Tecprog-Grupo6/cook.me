Rails.application.routes.draw do
  devise_for :users
  get '/' => 'home#index'
  root to: "home#index"

  as :user do
    get '/login', to: 'devise/sessions#new'
    post '/login', to: 'devise/sessions#create'
    get '/logout', to: 'devise/sessions#destroy'
    get '/perfil/senha/recuperar', to: 'devise/passwords#new'
    get '/perfil/senha/editar', to: 'devise/passwords#edit'
    patch '/perfil/senha/atualizar', to: 'devise/passwords#update'
    put '/perfil/senha/atualizar', to: 'devise/passwords#update'
    post '/perfil/senha/criar', to: 'devise/passwords#create'
    get '/perfil/cancelar', to: 'devise/registrations#cancel'
    get '/perfil/criar', to: 'devise/registrations#new'
    get '/perfil/editar', to: 'devise/registrations#edit'
    patch '/perfil/atualizar', to: 'devise/registrations#update'
    put '/perfil/atualizar', to: 'devise/registrations#update'
    delete '/perfil/excluir', to: 'devise/registrations#destroy'
    post '/perfil/criar', to: 'devise/registrations#create'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
