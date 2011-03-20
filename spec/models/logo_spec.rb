require 'spec_helper'

class FakeUpload
  def original_filename
    "/a/b/c/test-logo.test"
  end

  def read
    ""
  end
end

describe Logo do
  def logo_path
    "public/images/logo.test"
  end

  after(:each) do
    FileUtils.rm_rf(logo_path) if File.exists?(logo_path)
  end

  it "should write new logo to a file" do
    logo = Logo.new :image => FakeUpload.new
    logo.save
    File.exists?(logo_path).should == true
  end
end
