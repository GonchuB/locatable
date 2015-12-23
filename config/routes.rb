Rails.application.routes.draw do
  resources :reservations, only: [:index, :show, :create, :destroy] do
    member do
      put "assign"
    end
  end

  resources :tables, only: [:index, :show] do
    member do
      put "change_status"
    end
    collection do
      get "next_tables"
      get "average_stay_times"
    end
  end
end
