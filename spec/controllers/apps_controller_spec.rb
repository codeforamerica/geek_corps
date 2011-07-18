require 'spec_helper'

describe AppsController do

  def valid_attributes
    {}
  end

  describe "GET show" do
    it "assigns the requested app as @app" do
      app = Factory(:app)
      get :show, :id => app.id.to_s
      assigns(:app).should eq(app)
    end
  end
end
