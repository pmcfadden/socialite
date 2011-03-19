require 'spec_helper'

describe AppSettings do
  it "should reload setting as a number" do
    AppSettings.foo = 123
    AppSettings.foo.should == 123
  end

  it "should save settings from a hash of params" do
    AppSettings.update_settings :a => 1, :b => 2
    AppSettings.a.should == 1
    AppSettings.b.should == 2
  end
end

