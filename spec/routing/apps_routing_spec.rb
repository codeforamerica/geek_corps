require "spec_helper"

describe AppsController do
  describe "routing" do

    it "routes to #index" do
      get("/apps").should route_to("apps#index")
    end

    it "routes to #new" do
      get("/apps/new").should route_to("apps#new")
    end

    it "routes to #show" do
      get("/apps/1").should route_to("apps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/apps/1/edit").should route_to("apps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/apps").should route_to("apps#create")
    end

    it "routes to #update" do
      put("/apps/1").should route_to("apps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/apps/1").should route_to("apps#destroy", :id => "1")
    end

  end
end
