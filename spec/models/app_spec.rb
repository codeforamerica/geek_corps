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
  
  context 'aggregates skill list' do
      it 'skill_list' do
        s1 = Factory(:step, :app => @app,  :skill_list => ['one', 'two'])
        s2 = Factory(:step, :app => @app,  :skill_list => ['two'])
        s3 = Factory(:step, :app => @app,  :skill_list => ['two', 'three'])
        s4 = Factory(:step, :app => @app,  :skill_list => ['one', 'two'])
        s5 = Factory(:step, :app => @app,  :skill_list => ['two'])
        s6 = Factory(:step, :app => @app,  :skill_list => ['two', 'three'])        
        m1 = Factory(:milestone, :app => @app, :steps => [s3, s2, s1])
        m2 = Factory(:milestone, :app => @app, :steps => [s4, s5, s6])
        @app.reload.milestones.size.should == 2
        @app.reload.skill_list.should == ['one', 'two', 'three']
      end
    
  end
end
