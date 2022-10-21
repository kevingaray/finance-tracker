# frozen_string_literal: true

# model stock
class Stock < ApplicationRecord
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
end
