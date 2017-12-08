require 'spec_helper'

describe "increase the temperature" do

it "increase temperature" do
  ProjectDefaultPage.increase_temperature
  expect(page.has_content?("Welcome")).to be true
end

it "cancel increase temperature" do
  ProjectDefaultPage.cancel_increase_temperature
  expect(page.has_content?("Welcome")).to be true
end

end
