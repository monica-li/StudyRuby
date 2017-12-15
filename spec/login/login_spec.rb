require 'spec_helper'

describe "login the system" do
 before :all do
   SpecHelper::open_session_with_login
 end
 it "Login the system" do
   expect(page.has_content?("Welcome")).to be true
 end

 it "Logout the system" do
   Util::sign_out
   expect(page.has_content?("Welcome")).to be false
 end
 
 after :all do
   SpecHelper::open_session_with_login
 end
end
