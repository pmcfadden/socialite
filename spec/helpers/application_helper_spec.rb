require 'spec_helper'

describe ApplicationHelper do

  describe "app name" do
    it "should return the name of the app" do
      AppSettings.app_name = 'test-name'
      helper.app_name.should == 'test-name'
    end
  end

  describe "time ago in words including ago" do
    it "should return 1 minute ago" do 
        text = helper.time_ago_in_words_including_ago 1.minute.ago
        text.should == "1 minute ago"
    end
  end

  describe "resolve class for coloring comment" do
    it "should not add anything to the class names if comment is legit" do
      comment = mock(Comment, :is_spam? => false).as_null_object
      helper.resolve_class_for_coloring_comment(comment).should == ""
    end

    it "should add marked-as-spam to the class names if comment is spam" do
      comment = mock(Comment, :is_spam? => true).as_null_object
      helper.resolve_class_for_coloring_comment(comment).should == "marked-as-spam"
    end
  end
end
