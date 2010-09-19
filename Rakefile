# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rake'
require 'json'
require 'net/http'

task :cron => :environment do
	url = "http://uk.finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote;currency=true?format=json"
  body = Net::HTTP.get_response(URI.parse(url)).body.gsub(/,\s*\]/, ']')

	result = JSON.parse(body)
  puts result["list"]["resources"]

  Currency.delete_all
  result["list"]["resources"].each do |r|
    resource = r["resource"]["fields"]
    if /USD\/(.*)/.match(resource["name"])
      Currency.create(:name => $~[1], :rate => resource["price"])
    end
  end
end
