require 'spec_helper'

describe 'User' do

  context 'has accessible attribute' do
    before do
      @user = Factory(:user)
    end
    it("email") { @user.respond_to?(:email).should be_true }
    it("remember_me") { @user.respond_to?(:remember_me).should be_true }
  end
  context 'has association with' do
    before do
      @user = Factory(:user)
    end
    it('one person') { @user.respond_to?(:person).should be_true }
    it('many team_members') { @user.respond_to?(:team_members).should be_true }
    it('many teams') { @user.respond_to?(:teams).should be_true }
    it('one region') { @user.respond_to?(:region).should be_true }
    it('many authentications') { @user.respond_to?(:authentications).should be_true }
  end
  context 'validates' do
  end
  context 'methods' do
    before do
      @user = Factory(:user)
    end
    it 'returns a default image if theres an authentication but no image stored with that auth' do
      new_auth = @user.authentications.create!
      @user.authentications = [new_auth]
      @user.person = nil
      @user.save!
      @user.avatar_url.should == '/images/geekcorpsavatar1.png'
    end
  end
end
