require 'spec_helper'

describe Person do
  before do
    @person = Factory(:person)
  end
  context 'belongs to' do
    it 'user' do
      @person.respond_to?(:user).should be_true
    end
  end
  context 'validates' do
    it 'presence of name' do
      @person.name = nil
      @person.should have(1).error_on(:name)
    end
  end

end
