# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe "UserAdmin" do
  before(:each) do
    @auth = {:host=>SpecHelper.get_host, :port=>SpecHelper.get_port}
    @username = "john"
    @account_name = "testaccount"
    @role_name = "TestRole"
  end

  it "should get all the users" do
    # TODO
    expect(UserAdmin.get_all_users(@auth)[0]["username"]).to eql("admin")
  end

  it "should add a new user" do
    user = {
        "accounts"=>"cloud",
        "email"=>"john@example.com",
        "firstName"=>"John",
        "lastName"=>"Doe",
        "password"=>"john",
        "roles"=>"Administer",
        "username"=>"john"
    }
    UserAdmin.add_user(@auth, user)
  end

  it "should get the new user" do
    UserAdmin.get_user(@auth, @username)#["lastName"]).to == "Doe"
  end

  it "should update the last name" do
    props = {
        "accounts"=>"cloud",
        "email"=>"john@example.com",
        "firstName"=>"John",
        "lastName"=>"Doe_Update",
        "password"=>"john",
        "roles"=>"Administer",
        "username"=>"john"
    }
    UserAdmin.update_user(@auth, @username, props)
  end

  it "should delete the user" do
    UserAdmin.delete_user(@auth, @username)
  end

  it "should get all the account" do
    expect(UserAdmin.get_all_accounts(@auth)[0]["name"]).to eql("cloud")
  end

  it "should add a new account" do
    account = {
      "description"=>"test account",
      "ldapgroups"=>["group1","group2"],
      "name"=>"testaccount",
      "users"=>"admin"
    }
    UserAdmin.add_account(@auth, account)
  end

  it "should get the new account" do
    expect(UserAdmin.get_account(@auth, @account_name)["name"]).to eql(@account_name)
  end

  it "should update the new account" do
    props = {
      "description"=>"test account",
      "ldapgroups"=>[],
      "name"=>"testaccount",
      "users"=>"admin"
    }
    UserAdmin.update_account(@auth, @account_name, props)
    expect(UserAdmin.get_account(@auth, @account_name)["ldapgroups"]).to match_array([""])
  end

  it "should delete the new account" do
    UserAdmin.delete_account(@auth, @account_name)
  end

  it "should get all the roles" do
    expect(UserAdmin.get_all_roles(@auth)[0]["name"]).to eql("Administer")
  end

  it "should add a new role" do
    role = {
      "name"=>"TestRole",
      "description"=>"A Test Role",
      "ldapgroup"=>"group1",
      "permissions" => "Dashboard Console Manage,Dashboard Console View,Dashboard View,Component Publish,Stack Publish,
    Enabler Publish,Schedule Publish,Allocation Constraint Edit,Stack Activation,Component Edit,Archive Scaling Edit,
    Component Edit for Admin API from Engine,Component Testing,Stack Edit,Enabler Edit,Schedule Edit,Allocation Constraint View,
    Component Test View,Component Types View,Component View,Archive Scaling View,Stack Manager View,Stack View,Enabler View,
    Schedule View,Engine Daemon Manage,Engine Manage,Engine Properties Edit,Engine Properties List Edit,Engine Log Files,
    Browse Engine Work Directory"
    }
    UserAdmin.add_role(@auth, role)
  end

  it "should get the new role" do
    expect(UserAdmin.get_role(@auth, @role_name)["name"]).to eql(@role_name)
  end

  it "should update the new role" do
    props = {
      "name"=>"TestRole",
      "description"=>"A Test Role",
      "ldapgroup"=>"",
      "permissions" => "Dashboard Console Manage,Dashboard Console View,Dashboard View,Component Publish,Stack Publish,
    Enabler Publish,Schedule Publish,Allocation Constraint Edit,Stack Activation,Component Edit,Archive Scaling Edit,
    Component Edit for Admin API from Engine,Component Testing,Stack Edit,Enabler Edit,Schedule Edit,Allocation Constraint View,
    Component Test View,Component Types View,Component View,Archive Scaling View,Stack Manager View,Stack View,Enabler View,
    Schedule View,Engine Daemon Manage,Engine Manage,Engine Properties Edit,Engine Properties List Edit,Engine Log Files,
    Browse Engine Work Directory"
    }
    UserAdmin.update_role(@auth, @role_name, props)
    expect(UserAdmin.get_role(@auth, @role_name)["ldapgroup"]).to eql("")
  end

  it "should delete the new role" do
    UserAdmin.delete_role(@auth, @role_name)
  end

   it "should get all user sessions" do
     UserAdmin.get_all_sessions(@auth)
   end
end
