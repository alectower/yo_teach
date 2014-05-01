Rails.application.routes.draw do
  root 'calendar#calendar'
  get 'calendar', to: 'calendar#calendar', as: :calendar
  resources :users, only: [:new, :create, :show]
  get 'users/:id/edit/user', to: 'users#edit_user', as: :edit_user
  patch 'users/:id/edit/user', to: 'users#update_user', as: :update_user
  get 'users/:id/edit/password', to: 'users#edit_password',
    as: :edit_password
  patch 'users/:id/edit/password',
    to: 'users#update_password', as: :update_password
  get 'sign_in', to: 'sessions#new', as: :new_session
  post 'sign_in', to: 'sessions#create', as: :sessions
  delete 'sign_out', to: 'sessions#destroy', as: :sign_out
  resources :password_resets
  resources :courses
  resources :lesson_plans
  resources :lesson_plan_standards,
    only: [:create, :destroy]
  resources :to_dos, only: [:new, :create, :destroy]
  resources :lesson_plan_fields, only: [:destroy]
end
