Rails.application.routes.draw do
  root 'front_pages/homes#show'

  devise_for :users
end
