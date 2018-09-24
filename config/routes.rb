Rails.application.routes.draw do

  resources :timeslots
  resources :age_groups
  resources :graduations
  resources :course_types
  resources :belts do
    scope '/:locale' do

    end
  end
  resources :students do
    scope '/:locale' do

    end
  end
  resources :clients do
    scope '/:locale' do

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'clients#index'
end
