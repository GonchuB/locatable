Rails.application.routes.draw do
  resources :reservations, only: [:index, :show, :destroy] do
    member do
      put "assign"
    end
  end

  resources :tables, only: [:index, :show] do
    member do
      put "change_status"
    end
  end
end
