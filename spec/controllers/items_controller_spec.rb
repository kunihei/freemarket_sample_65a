require 'rails_helper'

describe ItemsController do
  describe 'GET #new' do
    it "renders the :show template" do
      get :show, params: {  id: 1 }
    end
  end
end