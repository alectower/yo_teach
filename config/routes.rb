Rails.application.routes.draw do
  root 'calendar#calendar'
  get 'calendar', to: 'calendar#calendar', as: :calendar
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :courses
  resources :lesson_plans
  resources :lesson_plan_standards,
    only: [:create, :destroy]
  resources :to_dos, only: [:new, :create, :destroy]
  resources :lesson_plan_fields, only: [:destroy]
end
