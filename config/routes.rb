Rails.application.routes.draw do
  root "dashboard#show"
  post "start",      to: "dashboard#start",      as: :start
  post "play_round", to: "dashboard#play_round", as: :play_round
  post "play_all",   to: "dashboard#play_all",   as: :play_all
  post "reset",      to: "dashboard#reset",      as: :reset

  get   "squad",           to: "squad#show",      as: :squad
  patch "squad/assign",    to: "squad#assign",    as: :squad_assign
  post  "squad/formation", to: "squad#formation", as: :squad_formation
  post  "squad/auto",      to: "squad#auto",      as: :squad_auto

  get "stats", to: "stats#index", as: :stats

  resources :players, only: %i[index create] do
    collection { patch :bulk } # salvar tudo de uma vez
  end

  resources :matches, only: %i[index show] do
    member do
      get   :live
      post  :start
      post  :tick
      post  :resume
      post  :formation
      patch :substitute
    end
  end
end
