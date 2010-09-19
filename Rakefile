# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rubygems'
require 'rake'
require 'active_record'
require 'net/http'

load 'models/currency.rb'

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['production'])

task :cron do
	url = "http://uk.finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote;currency=true?format=json"
  body = Net::HTTP.get_response(URI.parse(url)).body.gsub(/,\s*\]/, ']')

	result = JSON.parse(body)

  result["list"]["resources"].each do |r|
    resource = r["resource"]["fields"]
    if /USD\/(.*)/.match(resource["name"])
      Currency.find_by_name($~[1]).update_attributes(:rate => resource["price"])
    end
  end
end
