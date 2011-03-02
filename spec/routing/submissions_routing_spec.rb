require "spec_helper"

describe SubmissionsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/submissions" }.should route_to(:controller => "submissions", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/submissions/new" }.should route_to(:controller => "submissions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/submissions/1" }.should route_to(:controller => "submissions", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/submissions/1/edit" }.should route_to(:controller => "submissions", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/submissions" }.should route_to(:controller => "submissions", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/submissions/1" }.should route_to(:controller => "submissions", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/submissions/1" }.should route_to(:controller => "submissions", :action => "destroy", :id => "1")
    end

  end
end
