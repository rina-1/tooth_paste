Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  devise_for :admins, skip: :all
    devise_scope :admin do
      get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
      post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
      delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session' 
    end
  authenticated :admin do
    namespace :admins do
      resources :genres, only:[:index, :create]
      resources :pastes, only:[:new, :create]
      resources :admin_recommends, only:[:index, :new, :create, :edit, :update, :destroy]
    end
  end
end
