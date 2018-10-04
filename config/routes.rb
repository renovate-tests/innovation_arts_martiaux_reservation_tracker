Rails.application.routes.draw do


  devise_for :admins, controllers: {
      confirmations: 'admins/confirmations',
      passwords: 'admins/passwords',
      registrations: 'admins/registrations',
      sessions: 'admins/sessions',
      unlocks: 'admins/unlocks'

  }

  devise_scope :admins do

  end

  devise_for :users, controllers: {
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      unlocks: 'users/unlocks',
      index: 'users/index'
  }
  get 'admins/aditionnal_admins', to: 'admins#aditionnal_admins'
  get '/students' => 'students#index', :as => :authenticated_user_root
  get '/users' => 'users#index', :as => :authenticated_admin_root

  resources :users
  resources :admins
  resources :cash_payments

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

  resources :charges

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'students#index'
end
