require 'rubygems'
require 'rake'
require 'active_record'
require 'net/http'
require 'yaml'
require 'json'

dbconfig = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(dbconfig['production'])

load 'models/currency.rb'

namespace :currency do
  desc "Load currencies base information."
  task :create do
    result = JSON.parse(File.open('config/currencies.json').read)

    result.each do |r|
      Currency.where(shortname: r["shortname"]).
        first_or_create!.
        update_attributes!(longname: r["longname"], popular: r["highlight"] || false)
    end

    Currency.where.not(shortname: result.map {|r| r["shortname"] }).destroy_all
  end

  desc "Cron job to update the exchange rates"
  task :update => [:create] do
    url = "https://uk.finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote;currency=true?format=json"

    body = Net::HTTP.get_response(URI.parse(url)).body
    result = JSON.parse(body)

    Currency.update_all(rate: nil)
    Currency.where(shortname: 'USD').update_all(rate: 1.0)

    result["list"]["resources"].each do |r|
      resource = r["resource"]["fields"]
      if /USD\/(.*)/.match(resource["name"])
        currency = Currency.where(shortname: $~[1]).first
        currency.update_attributes!(rate: resource["price"]) unless currency.nil?
      end
    end
  end
end

namespace :db do
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end

