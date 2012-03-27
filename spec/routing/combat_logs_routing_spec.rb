require "spec_helper"

describe CombatLogsController do
  describe "routing" do

    it "routes to #index" do
      get("/combat_logs").should route_to("combat_logs#index")
    end

    it "routes to #new" do
      get("/combat_logs/new").should route_to("combat_logs#new")
    end

    it "routes to #show" do
      get("/combat_logs/1").should route_to("combat_logs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/combat_logs/1/edit").should route_to("combat_logs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/combat_logs").should route_to("combat_logs#create")
    end

    it "routes to #update" do
      put("/combat_logs/1").should route_to("combat_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/combat_logs/1").should route_to("combat_logs#destroy", :id => "1")
    end

  end
end
