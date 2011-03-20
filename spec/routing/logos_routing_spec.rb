require "spec_helper"

describe LogosController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/admin/logo/new" }.should route_to(:controller => "logos", :action => "new")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/logo" }.should route_to(:controller => "logos", :action => "create")
    end

  end
end
