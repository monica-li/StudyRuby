# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'rest_client'
require 'json'
require 'uri'

module SilverFabric
  module Rest
    module RestAgent
      class << self
        ##
        # A helper method to get the REST agent
        #
        #    auth = {:host=>"lin64vm33.qa.datasynapse.com", :port=>"8080", :user=>"admin", :password=>"admin"}
        #    rest_agent = get_rest_agent(auth)
        #
        # @param [Hash] auth  the authentication to login the fabric server, the default username and password are "admin" and "admin"
        #                     the valid keys are :
        #                         :host [String] the host name
        #                         :port [String] the fabric http port
        #                         :username [String] the username of fabric server
        #                         :password [String] the password for the username
        #                         :protocol [String] the protocol of the fabric server, http or https
        #
        def get_rest_agent(auth, context = "sf")
          auth = {:username=>"admin", :password=>"admin"}.merge(auth)
          if !auth[:protocol].nil? and auth[:protocol].downcase == "https"
            RestClient::Resource.new("https://#{auth[:host]}:#{auth[:port]}/livecluster/rest/v1/#{context}", :user=>auth[:username], :password=>auth[:password], :verify_ssl=>OpenSSL::SSL::VERIFY_NONE)
          else
            if auth[:timeout].nil?
              RestClient::Resource.new("http://#{auth[:host]}:#{auth[:port]}/livecluster/rest/v1/#{context}", :user=>auth[:username], :password=>auth[:password])
            else
              RestClient::Resource.new("http://#{auth[:host]}:#{auth[:port]}/livecluster/rest/v1/#{context}", :user=>auth[:username], :password=>auth[:password], :timeout=>auth[:timeout], :open_timeout=>auth[:timeout])
            end
          end
        end

        ##
        # A helper method to get the json document from a hash, the return value can be used to create component or stack
        #
        # @param [Hash] json_hash  a hash which can be converted to json format
        #get_json_from_hash
        def get_json_from_hash(json_hash)
          JSON.generate(json_hash)
        end
        alias_method :get_json_doc, :get_json_from_hash
        
        ##
        # A helper method to get a hash from a json file
        #
        # @param [String] json_file the json file path, such as File.expand_path(File.dirname(__FILE__) + '/sffl_acceptance_stack.json')
        #
        def get_hash_from_json_file(json_file, opt={})
          document = File.read(json_file)
          opt.each do |k,v|
            document = document.gsub(/\$#{k}/,v)
          end
          JSON.parse(document)
        end
        alias_method :get_json_hash_from_file, :get_hash_from_json_file

        ##
        # A helper method to get a hash from a json string
        #
        # @param [String] json_file the json string
        #
        def get_hash_from_json_string(json, opt={})
          opt.each do |k,v|
            json = json.gsub(/\$#{k}/,v)
          end
          JSON.parse(json)
        end
        alias_method :get_json_hash_from_string, :get_hash_from_json_string

        ##
        # A helper method to convert an array of hash to a hash, the array is like this:
        #    "properties":[{"name":"Activation Id","value":"879993741"},{"name":"ActivationTime","value":"test"}]
        #
        # - @param [Array]  array_of_hash
        #
        def array_to_hash(array_of_hash)
          new_hash = {}
          array_of_hash.each do |a|
            new_hash[a["name"]] = a["value"]
          end
          new_hash
        end

        ##
        # A helper method to convert the hash which is get from REST api
        #    "properties":[{"name":"Activation Id","value":"879993741"},{"name":"ActivationTime","value":"test"}]
        #
        # - @param [Hash]  json_hash
        #
        def convert_json_hash(json_hash)
          json_hash.each do |k, v|
            if v.class == Array
              json_hash[k] = array_to_hash(v)
            end
            if v.class == Hash
              convert_json_hash(v)
            end
          end
        end

        ##
        # A helper method to convert all the hash in the Array which is get from REST api
        #    "properties":[{"name":"Activation Id","value":"879993741"},{"name":"ActivationTime","value":"test"}]
        #
        # - @param [Array]  array_of_hash
        #
        def convert_to_hash(array_of_hash)
          array_of_hash.each do |e|
            convert_json_hash(e)
          end    
        end
      end
    end
  end
end
