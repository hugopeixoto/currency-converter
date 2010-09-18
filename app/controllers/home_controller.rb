class HomeController < ApplicationController
  def index
    @currencies = Currency.all
  end
end
