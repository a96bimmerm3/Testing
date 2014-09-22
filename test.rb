require 'rubygems'
require 'oauth'
require 'twitter'
require 'json'

# Change the following values to those provided on dev.twitter.com
# The consumer key identifies the application making the request.
# The access token identifies the user making the request.
consumer_key = OAuth::Consumer.new(
    "2Zc9bGY0c30LjJSvPDonQIMd0",
    "FKWcHpBJY9gRVdigkHYupLxRMq3hMOtFZZ5Kbqb8nCJ8Xsc41R")
access_token = OAuth::Token.new(
    "1148276070-rnf2CMJl6dtC4aoINp59mdxvzLPq8rE33ZXLXze",
    "xMPFDnPOzNR7GnHDrpQ4oGuOxFyB2Hn9k0OJ7DOfk8b6G")

# All requests will be sent to this server.
baseurl = "https://api.twitter.com"

path    = "/1.1/search/tweets.json?src=typd&q=real%20estate%20capital"
query   = URI.encode_www_form(

    "count" => 20,
)

address = URI("#{baseurl}#{path}?#{query}")
request = Net::HTTP::Get.new address.request_uri

# Print data about a Tweet
def print_tweet(tweets)
gets tweets.each do |tweet| puts tweet["text"]
end
end

# Set up Net::HTTP to use SSL, which is required by Twitter.
http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# Build the request and authorize it with OAuth.
request = Net::HTTP::Get.new address.request_uri
request.oauth! http, consumer_key, access_token

# Issue the request and return the response.
http.start
response = http.request request
puts "The response status was #{response.code}"

tweets = nil
if response.code == '200' then
tweets = JSON.parse(response.body)
print_tweet(tweets)
end
nil
