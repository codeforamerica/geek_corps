require 'spec_helper'

describe TeamMember do
  before do
    @team_member = Factory(:team_member)
  end
  context 'belongs_to' do
    it 'user' do
      @team_member.respond_to?(:user).should be_true
    end
    it 'team' do
      @team_member.respond_to?(:user).should be_true
    end
    it 'app' do
      @team_member.respond_to?(:app).should be_true
    end
  end
end
