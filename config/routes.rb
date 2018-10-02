Rails.application.routes.draw do

  devise_for :admins, controllers: {
      confirmations: 'admins/confirmations',
      passwords: 'admins/passwords',
      registrations: 'admins/registrations',
      sessions: 'admins/sessions',
      unlocks: 'admins/unlocks'
  }

  devise_for :users, controllers: {
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      unlocks: 'users/unlocks'
  }

  resources :reservations
  resources :courses
  get '/courses_list' => 'courses#courses_list'
  resources :timeslots
  resources :age_groups
  resources :graduations
  resources :course_types
  resources :belts
  resources :students
  resources :clients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'clients#index'
end
