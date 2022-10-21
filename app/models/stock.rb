class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: ENV['EIX_PUBLISHABLE'],
      secret_token: ENV['EIX_SECRET'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    client.quote(ticker_symbol).latest_price
  end

end
