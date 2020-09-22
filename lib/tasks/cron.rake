require 'json'
require 'net/http'

task cron: :environment do
  result = "https://api.openrates.io/latest?base=EUR"
    .then(&URI.method(:parse))
    .then(&Net::HTTP.method(:get_response))
    .body
    .then(&JSON.method(:parse))

  Currency.transaction do
    Currency.delete_all

    Currency.create(name: "EUR", rate: 1.0)
    result["rates"].each do |name, rate|
      Currency.create(name: name, rate: rate)
    end

    Currency.where(name: %w[EUR USD JPY GBP]).update(popular: true)
    Currency.where.not(name: %w[EUR USD JPY GBP]).update(popular: false)
  end
end
