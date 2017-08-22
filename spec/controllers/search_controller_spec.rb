require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe 'GET #search' do

    it 'does call search with thinking sphinx' do
      expect(ThinkingSphinx).to receive(:search).with('test', classes: [Answer])
      get :search, params: { search: { query: 'test', target: 'answers' } }
    end
  end
end