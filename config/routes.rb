Rails.application.routes.draw do

  devise_for :users
  resources :questions do
    resources :answers, shallow: true do
      post :best_answer, on: :member
    end
  end
  resources :attachments, only: [:destroy]
  root to: 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
