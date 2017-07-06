Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

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
