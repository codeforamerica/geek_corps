require 'spec_helper'

describe Detail do
  before do
    @detail = Factory.build(:detail)
  end
  context 'belongs to' do
    it 'app' do
      @detail.respond_to?(:app).should be_true
    end
    it 'team' do
      @detail.respond_to?(:team).should be_true
    end
  end
  context 'validates' do
    it 'unique name' do
      attr = Factory.attributes_for(:detail)
      @detail = Detail.new(attr)
      @detail.save!
      @invalid_detail = Detail.new(attr)
      @invalid_detail.should have(1).error_on(:name)
    end
  end
end
