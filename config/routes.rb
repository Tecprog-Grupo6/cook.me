Rails.application.routes.draw do

  devise_for :users, :controllers => {registrations: 'users/registrations'}
  resources :users, only: [ :show, :edit, :update, ]
  resources :recipes

  root to: "feed#show"
  get '/' => 'feed#show'
  get '/receita/visualizar/:recipe_id' => 'recipe#show'
  get '/receita/criar' => 'recipe#new'
  get '/receita/editar/:recipe_id' => 'recipe#edit'
  post '/receita/' => 'recipe#save_new'
  post '/receita/:recipe_id' => 'recipe#save_old'
  post '/receita/deletar/:recipe_id' => 'recipe#delete'
  get '/buscar' => 'search#index'
  get '/buscar/:query' => 'search#get_results'
  post '/buscar' => 'search#get_query'
  get '/user/:username', to: 'perfil#show'
  post '/user/:username/followed_by/:current_user_username', to: 'perfil#follow'
  post '/user/:username/unfollowed_by/:current_user_username', to: 'perfil#unfollow'
  get '/user/:username/chat' => 'chat_room#show'
  post '/user/:username/chat' => 'chat_room#create'
  post '/user/:username/chat/destroy' => 'chat_room#destroy'
  post '/user/:username/chat/refresh' => 'chat_room#refresh'

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
