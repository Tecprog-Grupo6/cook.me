Rails.application.routes.draw do


  get 'perfil/show'

  devise_for :users, :controllers => {registrations: 'users/registrations'}
  resources :users, only: [ :show, :edit, :update, :rate_up]
  resources :recipes

  root to: "home#index"
  get '/' => 'home#index'
  get '/receita/visualizar/:recipe_id' => 'recipe#show'
  get '/receita/criar' => 'recipe#new'
  get '/receita/editar/:recipe_id' => 'recipe#edit'
  post '/receita/' => 'recipe#save_new'
  post '/receita/:recipe_id' => 'recipe#save_old'
  post '/receita/rate_up/:recipe_id', to: 'perfil#rate_up'
  get '/buscar' => 'search#index'
  post '/buscar' => 'search#show_results'
  get '/user/:username', to: 'perfil#show'
  post '/user/:username/followed_by/:current_user_username', to: 'perfil#follow'
  post '/user/:username/unfollowed_by/:current_user_username', to: 'perfil#unfollow'

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
    post '/perfil/atualizar', to: 'users/registrations#update'
    delete '/perfil/excluir', to: 'users/registrations#destroy'
    post '/perfil/criar', to: 'users/registrations#create'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
