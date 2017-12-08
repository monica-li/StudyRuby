require 'spec_helper'

describe "login the system" do

it "Login the system" do
  SpecHelper::open_session_with_login
  expect(@session).to have_content('Welcome')
end

end
