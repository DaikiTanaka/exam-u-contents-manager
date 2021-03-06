Rails.application.routes.draw do

  root 'photos#index'

  resource :sessions, only: %i[new create destroy]
  resources :photos, only: %i[index new create] do
    get :download
    get :show_image
  end
  # MyTweetApps連携
  namespace :oauth do
    get :app
    get :auth_request
    get :callback
  end
  namespace :my_tweet_app do
    post :tweet
  end

end
