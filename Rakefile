# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rubygems'
require 'rake'
require 'active_record'
require 'net/http'

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['production'])

load 'models/currency.rb'

desc "Cron job to update the exchange rates"
task :cron do
	url = "http://uk.finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote;currency=true?format=json"

  print "Downloading rates..."
  STDOUT.flush
  body = Net::HTTP.get_response(URI.parse(url)).body.gsub(/,\s*\]/, ']')
  puts "\tdone."

	result = JSON.parse(body)

  print "Updating exchange rates..."
  STDOUT.flush

  Currency.all.each do |currency|
    currency.update_attributes(:rate => nil)
  end

  Currency.find_by_shortname('USD').update_attributes(:rate => 1.0)

  result["list"]["resources"].each do |r|
    resource = r["resource"]["fields"]
    if /USD\/(.*)/.match(resource["name"])
      currency = Currency.find_by_shortname($~[1])
      currency.update_attributes(:rate => resource["price"]) unless currency.nil?
    end
  end

  puts "\tdone."
end

desc "Bootstrap the currency database."
task :bootstrap do
  result = JSON.parse(File.open('config/currencies.json').read)

  result.each do |r|
    Currency.create!(:longname => r["longname"], :shortname => r["shortname"], :popular => r["highlight"] || false)
  end

  Rake::Task[:cron].invoke
end

namespace :db do
  desc "Migrate the database"
  task :migrate do
    #ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end

