Rails.application.routes.draw do
  get 'players/create'
  get 'players/destroy'
  get 'players/approve'
  get 'players/reject'
  devise_for :users

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get "dashboard", to: "pages#dashboard"

  resources :leagues do
    resources :fixtures
    resources :league_teams_join, only: [:create]
    resources :favourites, only: [:create]
  end

  resources :teams do
    resources :players, only: [:create, :destroy]
  end

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  resources :league_teams_join, only: [:destroy]
  resources :favourites, only: [:destroy]

  patch "/league_teams_join/:id/approve", to: "league_teams_join#approve", as: :approve
  patch "/league_teams_join/:id/reject", to: "league_teams_join#reject", as: :reject
  patch "/player/:id/approve", to: "players#approve", as: :player_approve
  patch "/player/:id/reject", to: "players#reject", as: :player_reject
  post "/leagues/:league_id/fixtures/generate", to: "leagues#generate_fixtures", as: :generate_fixtures
end
