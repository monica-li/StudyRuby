require "rspec"
require "net/http"

describe "visit website" do

it "try rspec" do
  expect(200).to eql(200)
  expect("200").to eql("200")
end

it "baidu visit" do
  code = Net::HTTP.get_response(URI("http://www.baidu.com")).code
  expect(code).to eql("200")
end

end