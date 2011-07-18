require 'spec_helper'

describe Region do
  before do
    @region = Factory(:region)
  end
  context 'has many' do
    it 'teams' do
      @region.respond_to?(:teams).should be_true
    end
    it 'users' do
      @region.respond_to?(:users).should be_true
    end
  end
  context 'validates' do
    it 'uniqueness of city' do
      attr = Factory.attributes_for(:region)
      @region = Region.new(attr)
      @region.save!
      @invalid_region = Region.new(attr)
      @invalid_region.should have(1).error_on(:city)
    end
    it 'presence of nick_name' do
      @region.nick_name = nil
      @region.should have(1).error_on(:nick_name)
    end
  end
end
