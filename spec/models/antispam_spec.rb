require 'spec_helper'

describe Antispam do
  before :each do
    FileUtils.rm_rf("test-antispam-memory") if File.exists? "test-antispam-memory"
  end

  it "should reload snapshot if found" do
    antispam = Antispam.new "test-antispam-memory"
    antispam.trained_entries.should eq(0)

    antispam.train_as_spam Submission.new({:title => "title", :description => "description"})
    antispam.trained_entries.should eq(2)

    Antispam.new("test-antispam-memory").trained_entries.should eq(2)
  end
end

