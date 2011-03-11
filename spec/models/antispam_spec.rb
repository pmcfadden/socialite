require 'spec_helper'

describe Antispam do
  before :each do
    FileUtils.rm_rf("test-antispam-memory") if File.exists? "test-antispam-memory"
    @submission = Submission.new(:title => "title", :description => "description")
  end

  it "should reload snapshot if found" do
    antispam = Antispam.new "test-antispam-memory"
    antispam.trained_entries.should eq(0)

    antispam.train_as_content @submission
    antispam.trained_entries.should eq(2)

    Antispam.new("test-antispam-memory").trained_entries.should eq(2)
  end

  it "should untrain when switching to spam" do 
    antispam = Antispam.new "test-antispam-memory"
    antispam.trained_entries.should eq(0)
    antispam.train_as_content @submission
    antispam.trained_entries.should eq(2)
    antispam.switch_to_spam @submission
    antispam.trained_entries.should eq(2)
  end

  it "should not throw an error when trying to untrain when there are no words in the classifier" do
    Antispam.new.switch_to_spam @submission
  end
end

