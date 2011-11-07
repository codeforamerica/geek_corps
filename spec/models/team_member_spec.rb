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
      @team_member.respond_to?(:team).should be_true
    end
  end
  context 'validations' do
    it 'must have a user' do
      @team_member.user = nil
      @team_member.should have(1).error_on(:user)
    end
    it 'must have a team' do
      @team_member.team = nil
      @team_member.should have(1).error_on(:team)
    end
  end
end
