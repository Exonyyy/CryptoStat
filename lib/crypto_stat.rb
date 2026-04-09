require_relative "crypto_stat/version"
require_relative "crypto_stat/api_client"
require_relative "crypto_stat/analyzer"
require_relative "crypto_stat/portfolio_calculator"
require_relative "crypto_stat/chart_drawer"
require_relative "crypto_stat/crypto_app"

module CryptoStat
  class Error < StandardError; end
end
