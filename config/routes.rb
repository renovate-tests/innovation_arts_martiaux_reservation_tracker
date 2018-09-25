Rails.application.routes.draw do

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
