Rails.application.routes.draw do
  root 'front_pages/homes#show'

  devise_for :users

  namespace :dashboard do
    root 'homes#show'
  end
end
