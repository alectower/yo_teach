Rails.application.routes.draw do

  root 'calendar#calendar'
  get 'calendar', to: 'calendar#calendar', as: :calendar
  resources :courses
  resources :lesson_plans, except: [:show]
  post :lesson_plan_standards,
    controller: :lesson_plan_standards, action: :create
  delete :lesson_plan_standards,
    controller: :lesson_plan_standards, action: :destroy
  resources :to_dos, except: [:show, :index]

  delete 'lesson_plan_fields', to: 'lesson_plan_fields#destroy'

end
