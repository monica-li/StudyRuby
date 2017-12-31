# To change this template, choose Tools | Templates
# and open the template in the editor.
require File.expand_path(File.dirname(__FILE__) + '/rest_agent')

module SilverFabric
  module Rest
    module UserAdmin
      class << self
        ##
        # A helper method to get all the users by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   get_all_users(auth)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        def get_all_users(auth)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          json = rest_agent['users'].get
          json_hash = SilverFabric::Rest::RestAgent.get_hash_from_json_string(json)
          json_hash["result"]["value"]
        end

        # A helper method to add user by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   user = {
        #       "accounts"=>"cloud",
        #       "email"=>"john@example.com",
        #       "firstName"=>"John",
        #       "lastName"=>"Doe",
        #       "password"=>"john",
        #       "roles"=>"Administer",
        #       "username"=>"john"
        #    }
        #   add_user(auth, user)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [hash] user  a hash of user properties
        def add_user(auth, user)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent['users'].post(user.to_json, :content_type=>"application/json")
        end

        ##
        # A helper method to delete user by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   username = "testuser"
        #   delete_user(auth, username)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [String] username  the username
        def delete_user(auth, username)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/#{username}"].delete
        end

        ##
        # A helper method to get user by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   username = "testuser"
        #   get_user(auth, username)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [String] username  the username
        def get_user(auth, username)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          json = rest_agent["users/#{username}"].get
          json_hash = SilverFabric::Rest::RestAgent.get_hash_from_json_string(json)
          json_hash["result"]["value"]
        end

        # A helper method to update user by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   username = "testuser"
        #   props = {
        #       "accounts"=>"testuser",
        #       "email"=>"john@example.com",
        #       "firstName"=>"John",
        #       "lastName"=>"Doe",
        #       "password"=>"john",
        #       "roles"=>"Administer",
        #       "username"=>"john"
        #    }
        #   update_user(auth, username, props)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [hash] props  a hash of user properties
        # - @param [String] username the user name
        def update_user(auth, username, props)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/#{username}"].put(props.to_json, :content_type=>"application/json")
        end

        ##
        # A helper method to get all the accounts by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   get_all_users(auth)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        def get_all_accounts(auth)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          json = rest_agent['users/accounts'].get
          json_hash = SilverFabric::Rest::RestAgent.get_hash_from_json_string(json)
          json_hash["result"]["value"]
        end

        # A helper method to add account by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   account = {
        #      "description"=>"test account",
        #      "ldapgroups"=>["group1","group2"],
        #      "name"=>"testaccount",
        #      "users"=>"admin"
        #    }
        #   add_account(auth, account)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [hash] account  a hash of account properties
        def add_account(auth, account)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent['users/accounts'].post(account.to_json, :content_type=>"application/json")
        end

        ##
        # A helper method to delete account by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   account_name = "testaccount"
        #   delete_account(auth, account_name)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [String] account_name  the account name
        def delete_account(auth, account_name)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/accounts/#{account_name}"].delete
        end

        ##
        # A helper method to get account by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   account_name = "testaccount"
        #   get_account(auth, account_name)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [String] account_name  the account name
        def get_account(auth, account_name)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          json = rest_agent["users/accounts/#{account_name}"].get
          json_hash = SilverFabric::Rest::RestAgent.get_hash_from_json_string(json)
          json_hash["result"]["value"]
        end

        # A helper method to update account by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   account_name = "testaccount"
        #   props = {
        #       "accounts"=>"testaccount",
        #       "email"=>"john@example.com",
        #       "firstName"=>"John",
        #       "lastName"=>"Doe",
        #       "password"=>"john",
        #       "roles"=>"Administer",
        #       "username"=>"john"
        #    }
        #   update_account(auth, account_name, props)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [hash] props  a hash of account properties
        # - @param [String] account_name the account name
        def update_account(auth, account_name, props)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/accounts/#{account_name}"].put(props.to_json, :content_type=>"application/json")
        end

        ##
        # A helper method to get all the roles by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   get_all_roles(auth)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        def get_all_roles(auth)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          json = rest_agent['users/roles'].get
          json_hash = SilverFabric::Rest::RestAgent.get_hash_from_json_string(json)
          json_hash["result"]["value"]
        end

        # A helper method to add role by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   role = {
        #      "name"=>"TestRole",
        #      "description"=>"A Test Role",
        #      "ldapgroup"=>"group1",
        #      "permissions" => "Dashboard Console Manage,Dashboard Console View,Dashboard View,Component Publish,Stack Publish,
        #    Enabler Publish,Schedule Publish,Allocation Constraint Edit,Stack Activation,Component Edit,Archive Scaling Edit,
        #    Component Edit for Admin API from Engine,Component Testing,Stack Edit,Enabler Edit,Schedule Edit,Allocation Constraint View,
        #    Component Test View,Component Types View,Component View,Archive Scaling View,Stack Manager View,Stack View,Enabler View,
        #    Schedule View,Engine Daemon Manage,Engine Manage,Engine Properties Edit,Engine Properties List Edit,Engine Log Files,
        #    Browse Engine Work Directory"
        #    }
        #   add_role(auth, role)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [hash] role  a hash of role properties
        def add_role(auth, role)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent['users/roles'].post(role.to_json, :content_type=>"application/json")
        end

        ##
        # A helper method to delete role by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   role_name = "testrole"
        #   delete_role(auth, role_name)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [String] role_name  the role name
        def delete_role(auth, role_name)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/roles/#{role_name}"].delete
        end

        ##
        # A helper method to get role by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   role_name = "testrole"
        #   get_role(auth, role_name)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [String] role_name  the role name
        def get_role(auth, role_name)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          json = rest_agent["users/roles/#{role_name}"].get
          json_hash = SilverFabric::Rest::RestAgent.get_hash_from_json_string(json)
          json_hash["result"]["value"]
        end

        # A helper method to update role by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   role_name = "TestRole"
        #   props = {
        #      "name"=>"TestRole",
        #      "description"=>"A Test Role",
        #      "ldapgroup"=>"group1",
        #      "permissions" => "Dashboard Console Manage,Dashboard Console View,Dashboard View,Component Publish,Stack Publish,
        #    Enabler Publish,Schedule Publish,Allocation Constraint Edit,Stack Activation,Component Edit,Archive Scaling Edit,
        #    Component Edit for Admin API from Engine,Component Testing,Stack Edit,Enabler Edit,Schedule Edit,Allocation Constraint View,
        #    Component Test View,Component Types View,Component View,Archive Scaling View,Stack Manager View,Stack View,Enabler View,
        #    Schedule View,Engine Daemon Manage,Engine Manage,Engine Properties Edit,Engine Properties List Edit,Engine Log Files,
        #    Browse Engine Work Directory"
        #    }
        #   update(auth, role_name, props)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [hash] props  a hash of role properties
        # - @param [String] role_name the role name
        def update_role(auth, role_name, props)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/roles/#{role_name}"].put(props.to_json, :content_type=>"application/json")
        end

        ##
        # A helper method to get all sessions by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   get_all_sessions(auth)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        def get_all_sessions(auth)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          json = rest_agent['users/sessions'].get
          json_hash = SilverFabric::Rest::RestAgent.get_hash_from_json_string(json)
          json_hash["result"]["value"]
        end

        ##
        # A helper method to delete all sessions by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   delete_all_sessions(auth)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        def delete_all_sessions(auth)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/sessions"].delete
        end

        ##
        # A helper method to a specified session by REST api
        #
        #   auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080"}
        #   session_key = "F8F922F8B980808265EA0B2A5337F201"
        #   delete_session(auth, session_key)
        #
        # - @param [hash] auth  the authentication of the fabric server, the default username and password are "admin" and "admin"
        #                       the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        # - @param [String] session_key the key of session
        def delete_session(auth, session_key)
          rest_agent = SilverFabric::Rest::RestAgent.get_rest_agent(auth)
          rest_agent["users/sessions/#{session_key}"].delete
        end
      end
    end
  end
end
