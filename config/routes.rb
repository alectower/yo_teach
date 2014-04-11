Rails.application.routes.draw do
  root 'calendar#calendar'
  get 'calendar', to: 'calendar#calendar', as: :calendar
  resources :users
  get 'log_in', to: 'sessions#new', as: :new_session
  post 'log_in', to: 'sessions#create', as: :sessions
  delete 'log_out', to: 'sessions#destroy', as: :log_out
  resources :accounts, only: [:show]
  resources :courses
  resources :lesson_plans
  resources :lesson_plan_standards,
    only: [:create, :destroy]
  resources :to_dos, only: [:new, :create, :destroy]
  resources :lesson_plan_fields, only: [:destroy]
end
