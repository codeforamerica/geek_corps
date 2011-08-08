require 'spec_helper'

describe App do
  before do
    @app = Factory(:app)
  end
  context 'has many' do
    it 'teams' do
      @app.respond_to?(:teams).should be_true
    end
    it 'details' do
      @app.respond_to?(:details).should be_true
    end
    it 'team_members' do
      @app.respond_to?(:team_members).should be_true
    end
    it 'users' do
      @app.respond_to?(:users).should be_true
    end
  end
  context 'validates' do
    it 'uniqueness of name' do
      attr = Factory.attributes_for(:app)
      @app = App.new(attr)
      @app.save!
      @invalid_app = App.new(attr)
      @invalid_app.should have(1).error_on(:name)
    end
  end
end
