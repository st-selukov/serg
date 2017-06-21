Rails.application.routes.draw do

  devise_for :users

  concern :votable do
    put :vote_up, on: :member
    put :vote_down, on: :member
    delete :destroy_vote, on: :member
  end

  resources :questions, concerns: [:votable] do
    resources :answers, concerns: [:votable], shallow: true do
      post :best_answer, on: :member
    end
  end

  resources :attachments, only: [:destroy]
  root to: 'questions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
