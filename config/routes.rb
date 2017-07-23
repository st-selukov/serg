Rails.application.routes.draw do

  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
      resources :questions
      resources :answers
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    post 'auth_confirm_email', to: 'omniauth_callbacks#auth_confirm_email'
  end

  concern :votable do
    put :vote_up, on: :member
    put :vote_down, on: :member
    delete :destroy_vote, on: :member
  end

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: [:votable, :commentable] do
    resources :answers, concerns: [:votable, :commentable], shallow: true do
      post :best_answer, on: :member
    end
  end

  resources :attachments, only: [:destroy]
  root to: 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
