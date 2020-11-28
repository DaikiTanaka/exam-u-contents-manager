Rails.application.routes.draw do

  root 'photos#index'

  resource :sessions, only: %i[new create destroy]
  resources :photos, only: %i[index new create] do
    get :download
  end
  # MyTweetApps連携
  namespace :oauth do
    get :app
    get :auth_request
    get :callback
  end

end
