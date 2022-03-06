Rails.application.routes.draw do
  root 'front_pages/homes#show'

  devise_for :users

  namespace :dashboard do
    root 'homes#show'

    resources :channels do
      resource :channels_users, only: %i[create destroy]
    end
  end
end
