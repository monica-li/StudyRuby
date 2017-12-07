require "rspec"
require 'capybara/dsl'
require 'selenium-webdriver'

describe "baidu test" do

before (:all) do
  @url="http://www.baidu.com" 
  @session = Capybara::Session.new(:selenium)
end

it "baidu visit" do
  @session.visit @url
  expect(@session.has_content?("Baidu")).to be(true)
end

it "Search in Baidu" do
  @session.fill_in('wd',:with => 'TestT')
  @session.click_button('su')
  expect(@session).to have_content('TestT')
end

end
