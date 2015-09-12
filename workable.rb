require 'rubygems'
require 'httparty'

results = HTTParty.get('http://www.workable.com/spi/v3/accounts/boxbee/jobs', query: {:state => "published"}, headers: {"Authorization" => "Bearer 09be11f46903591b055a56930a72494bca16ec5ea7a2eed9c403dc9deaad8884"})

results["jobs"].each do |job|
  puts job["title"]
end
