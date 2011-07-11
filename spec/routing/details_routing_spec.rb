require "spec_helper"

describe DetailsController do
  describe "routing" do

    it "routes to #index" do
      get("/details").should route_to("details#index")
    end

    it "routes to #new" do
      get("/details/new").should route_to("details#new")
    end

    it "routes to #show" do
      get("/details/1").should route_to("details#show", :id => "1")
    end

    it "routes to #edit" do
      get("/details/1/edit").should route_to("details#edit", :id => "1")
    end

    it "routes to #create" do
      post("/details").should route_to("details#create")
    end

    it "routes to #update" do
      put("/details/1").should route_to("details#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/details/1").should route_to("details#destroy", :id => "1")
    end

  end
end
