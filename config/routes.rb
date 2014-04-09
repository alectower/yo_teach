Rails.application.routes.draw do
  root 'calendar#calendar'
  get 'calendar', to: 'calendar#calendar', as: :calendar
  resources :courses
  resources :lesson_plans
  resources :lesson_plan_standards,
    only: [:create, :destroy]
  resources :to_dos, except: [:show, :index]
  resources :lesson_plan_fields, only: [:destroy]
end
