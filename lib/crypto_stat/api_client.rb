require 'net/http'
require 'json'

module CryptoStat
  class ApiClient
    COINS = {
      'Биткоин (BTC)' => 'bitcoin',
      'Эфириум (ETH)' => 'ethereum',
      'ТОН (TON)' => 'the-open-network'
    }.freeze

    RATES = {
      'USD' => 1.0,
      'EUR' => 0.92,
      'RUB' => 92.5
    }.freeze

    def fetch_data(coin_name)
      coin_id = COINS[coin_name]
      raise ArgumentError, "Неизвестная монета: #{coin_name}" unless coin_id

      @last_coin_id = coin_id
      
      url = URI("https://api.coingecko.com/api/v3/coins/#{coin_id}/market_chart?vs_currency=usd&days=365")

      response = Net::HTTP.get(url)
      data = JSON.parse(response)

      data['prices'].map { |item| item[1] }
    rescue ArgumentError => e
      raise e
    rescue JSON::ParserError => e
      warn "⚠️ Ошибка парсинга API ответа: #{e.message}. Используются тестовые данные..."
      generate_mock_data
    rescue StandardError => e
      warn "⚠️ Ошибка запроса API: #{e.message}. Используются тестовые данные..."
      generate_mock_data
    end

    private

    def generate_mock_data
      # Генерируем 365 дней тестовых данных с реалистичными колебаниями
      base_price = case @last_coin_id
                   when 'bitcoin' then 45000.0
                   when 'ethereum' then 2500.0
                   else 5.0
                   end

      (0..364).map do |day|
        variation = (rand - 0.5) * (base_price * 0.02) # Случайное изменение ±2%
        base_price = base_price + variation
        base_price.round(2)
      end
    end

    public

    def get_coins_list
      COINS.keys
    end

    def convert_prices(prices, currency)
      raise ArgumentError, "Неизвестная валюта: #{currency}" unless RATES.key?(currency)

      rate = RATES[currency]
      prices.map { |price| price * rate }
    end
  end
end
