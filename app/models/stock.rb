# frozen_string_literal: true

# model stock
class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true
  before_save { self.ticker = ticker.upcase }

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: ENV['EIX_PUBLISHABLE'],
      secret_token: ENV['EIX_SECRET'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )

    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name,
          last_price: client.quote(ticker_symbol).latest_price)
    rescue StandardError
      nil
    end
  end

  def self.check_db(ticker_symbol)
    find_by(ticker: ticker_symbol)
  end

  def update_last_prices
    Stock.all.each do |stock|
      stock.update(last_price: Stock.new_lookup(stock.ticker).last_price)
    end
  end
end


