Rails.application.routes.draw do
  get 'inquiries/new'
  get 'inquiries/create'
  root 'homes#top'

  resources :inquiries, only:[:new, :create]
  # get 'auth/:provider/callback', to: 'sessions#create'
  # get '/logout', to: 'sessions#destroy'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
   devise_scope :user do
    # get '/users/sign_in' => 'users/sessions#new', as: 'new_user_session'
    # # post '/users/sign_in' => 'users/sessions#create', as: 'user_session'
    # delete '/users/sign_out' => 'users/sessions#destroy', as: 'destroy_user_session'
    # get '/users/sign_up' => 'users/registrations#new', as: 'new_user_registration'
    get '/users/passwords/edit' => 'users/registrations#edit', as: 'password_edit_registrations'
    patch '/users/passwords/update' => 'users/registrations#update'
    # post 'users/sign_up' => 'users/registrations#create', as: 'user_registration'
    # get '/users/' => 'users/passwords#edit', as: 'edit_user_password'
    # patch '/users/passwords' => 'users/passwords#update', as: 'user_password'
    get '/users/passwords/new' => 'users/passwords#new',as: 'user_forgot_password'
   end

  namespace :users do
    get 'users/select' => 'user_favorites#select', as: 'select_user_favorite'
    get 'users/new/:id' => 'user_favorites#new', as: 'new_user_favorite'
    resources :user_favorites, only:[:create, :show, :edit, :update, :destroy, :index]
    get 'users/genre_index' => 'pastes#genre_index', as: 'genre_index_paste'
    resources :pastes
  end
  # resources :pastes do
  #   resources :user_favorites
  # end


  devise_for :admins, skip: :all
    devise_scope :admin do
      get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
      post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
      delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session' 
    end
  authenticated :admin do
    namespace :admins do
      resources :genres, only:[:index, :create, :destroy, :edit, :update]
      resources :pastes, only:[:new, :create, :edit, :update, :destroy] do
         collection { post :import }
        # collection { post :csv_import }
      end
      resources :admin_recommends, only:[:index, :new, :create, :edit, :update, :destroy]
    end
  end
end
