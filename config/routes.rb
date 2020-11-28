Rails.application.routes.draw do

  root 'photos#index'

  resource :sessions, only: %i[new create destroy]
  resources :photos, only: %i[index new create] do

    get :download
  end

end
