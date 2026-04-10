require "test_helper"

class ChartDrawerTest < Minitest::Test
  def setup
    @chart_drawer = CryptoStat::ChartDrawer.new
  end

  def test_get_month_prices_last_30
    prices = (1..100).map { |i| 100.0 + i }.to_a
    month_prices = @chart_drawer.get_month_prices(prices)

    assert_equal 30, month_prices.length
    assert_equal 171.0, month_prices.first
    assert_equal 200.0, month_prices.last
  end

  def test_get_month_prices_less_than_30
    prices = (1..10).map { |i| 100 + i }.to_a
    month_prices = @chart_drawer.get_month_prices(prices)

    assert_equal 10, month_prices.length
  end

  def test_get_month_prices_empty_array
    prices = []
    assert_raises ArgumentError do
      @chart_drawer.get_month_prices(prices)
    end
  end

  def test_get_month_prices_single_element
    prices = [100]
    month_prices = @chart_drawer.get_month_prices(prices)

    assert_equal 1, month_prices.length
    assert_equal 100, month_prices[0]
  end

  def test_draw_with_empty_prices
    prices = []
    assert_raises ArgumentError do
      @chart_drawer.draw(nil, prices)
    end
  end

  def test_get_month_prices_with_sample_data
    prices = SAMPLE_PRICES
    month_prices = @chart_drawer.get_month_prices(prices)

    assert_equal 30, month_prices.length
    month_prices.each { |price| assert_kind_of Numeric, price }
  end
end
