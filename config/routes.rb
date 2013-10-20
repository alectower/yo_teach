Rails.application.routes.draw do

  root 'calendar#calendar'
  get 'calendar', to: 'calendar#calendar', as: :calendar
  resources :courses
  resources :lesson_plans
  resources :to_dos, except: [:show, :index]

  delete 'lesson_plan_fields', to: 'lesson_plan_fields#destroy'
end
