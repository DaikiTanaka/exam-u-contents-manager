Rails.application.routes.draw do

  root 'photos#index'

  resource :sessions, only: %i[new create]

end
