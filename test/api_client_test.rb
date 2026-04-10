require "test_helper"

class ApiClientTest < Minitest::Test
  def setup
    @api = CryptoStat::ApiClient.new
  end

  def test_get_coins_list
    coins = @api.get_coins_list
    assert_includes coins, 'Биткоин (BTC)'
    assert_includes coins, 'Эфириум (ETH)'
    assert_includes coins, 'ТОН (TON)'
    assert_equal 3, coins.length
  end

  def test_get_coins_list_returns_array
    coins = @api.get_coins_list
    assert_instance_of Array, coins
  end

  def test_convert_prices_usd
    prices = [100, 200, 300]
    converted = @api.convert_prices(prices, 'USD')
    assert_equal prices, converted
  end

  def test_convert_prices_eur
    prices = [100, 200, 300]
    converted = @api.convert_prices(prices, 'EUR')
    assert_equal 92.0, converted[0]
    assert_equal 184.0, converted[1]
    assert_equal 276.0, converted[2]
  end

  def test_convert_prices_rub
    prices = [100, 200]
    converted = @api.convert_prices(prices, 'RUB')
    assert_equal 9250.0, converted[0]
    assert_equal 18500.0, converted[1]
  end

  def test_convert_prices_unknown_currency
    prices = [100, 200]
    assert_raises ArgumentError do
      @api.convert_prices(prices, 'XYZ')
    end
  end

  def test_convert_prices_with_empty_array
    prices = []
    converted = @api.convert_prices(prices, 'USD')
    assert_equal [], converted
  end

  def test_fetch_data_invalid_coin
    assert_raises CryptoStat::Error do
      @api.fetch_data('Unknown Coin')
    end
  end
end
