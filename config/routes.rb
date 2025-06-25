Rails.application.routes.draw do
  root 'courses#index'
  resources :courses, only: [:index, :show]

  # Debug route (development only)
  get '/debug/meta-tags', to: 'debug#meta_tags' if Rails.env.development?
end
