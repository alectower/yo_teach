Rails.application.routes.draw do

  root 'calendar#month'
  get 'calendar/:year/:month', to: 'calendar#month', as: :calendar
  resources :courses
  resources :lesson_plans
  resources :to_dos, except: [:show, :index]

end
