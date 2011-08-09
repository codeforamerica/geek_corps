require 'spec_helper'

describe PeopleController do

  describe "GET index" do
    it "assigns all people as @people" do
      @person = Person.create(:name => 'Harvey Jenkins')
      get :index
      assigns(:people).should eq([@person])
    end
  end

  describe "GET show" do
    it "assigns the requested person as @person" do
      @person = Person.create(:name => 'Harvey Jenkins')
      get :show, :id => @person.id.to_s
      assigns(:person).should eq(@person)
    end
  end

  describe "GET new" do
    it "assigns a new person as @person" do
      controller.stub!(:authenticate_user!).and_return(true)
      get :new
      assigns(:person).should be_a_new(Person)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before do
        current_user = Factory(:user)
        current_user.stub!(:admin?).and_return(true)
        controller.stub!(:authenticate_user!).and_return(true)
        controller.stub!(:current_user).and_return(current_user)
      end
      it "creates a new Person" do
        expect {
          post :create, :person => {:name => 'Harvey Jenkins'}
        }.to change(Person, :count).by(1)
      end

      it "assigns a newly created person as @person" do
        post :create, :person => {:name => 'Harvey Jenkins'}
        assigns(:person).should be_a(Person)
        assigns(:person).should be_persisted
      end

      it "redirects to the created person" do
        post :create, :person => {:name => 'Harvey Jenkins'}
        response.should redirect_to(Person.last)
      end
    end

    describe "with invalid params" do
    end
  end
  describe "PUT update" do
  end
end
