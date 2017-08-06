class SearchController < ApplicationController
  before_action :load_query, :find_target, only: :search

  def search
    @result = ThinkingSphinx.search(@query, classes: [@target])
  end

  private

  def find_target
    models = { answers: Answer, questions: Question, comments: Comment,
               users: User, everywhere: ThinkingSphinx }
    @target = models[params[:search][:target].to_sym]
  end

  def load_query
    @query = params[:search][:query]
  end
end
