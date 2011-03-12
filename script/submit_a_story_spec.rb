#
#  This was an attempt at using vapir to test the app.
#  However, it was too slow be usable.
#
require 'spec_helper'

describe "a user submitting a story" do
  if !Gem.available? 'vapir-firefox'
    puts "skipping this test as vapir-firefox is not installed"
    next 
  end

  require 'vapir-firefox'

  it "should submit a story" do
    browser = Vapir::Firefox.new
    begin
      browser.goto("http://localhost:3000")
      sign_out_link = browser.link(:text, "Sign out")
      sign_out_link.click if sign_out_link.exists?

      browser.link(:text, "Sign up").click
      browser.text_field(:name, "user[username]").set "watir"
      browser.text_field(:name, "user[email]").set "watir@example.com"
      browser.text_field(:name, "user[password]").set "123456"
      browser.text_field(:name, "user[password_confirmation]").set "123456"
      browser.button(:name, "commit").click

      browser.div(:class, "notice").text.should include("You have signed up successfully")

      browser.link(:text, "Submit a new story").click
      browser.text_field(:name, "submission[title]").set "watir"
      browser.text_field(:name, "submission[url]").set "example.com"
      browser.text_field(:name, "submission[description]").set "watir's description"
      browser.button(:name, "commit").click

      browser.div(:class, "notice").text.should include("You have signed up successfully")

    ensure
      browser.close
    end
  end
end

