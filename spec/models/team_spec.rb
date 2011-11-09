require 'spec_helper'

describe Team do
  context 'associates' do
    before do
      @team = Factory.build(:team)
    end
    it 'many team members' do
      @team.respond_to?(:team_members).should be_true
    end
    it 'many members' do
      @team.respond_to?(:members).should be_true
    end
  end
end
