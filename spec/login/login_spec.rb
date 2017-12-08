require 'spec_helper'

describe "login the system" do

 it "Login the system" do
   SpecHelper::open_session_with_login
   expect(page.has_content?("Welcome")).to be true
 end

 it "Logout the system" do
   Util::sign_out
   expect(page.has_content?("Welcome")).to be false
 end

end
