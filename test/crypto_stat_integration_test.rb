require "test_helper"

class CryptoStatIntegrationTest < Minitest::Test
  def test_module_loads
    assert defined?(CryptoStat)
  end

  def test_version_exists
    assert defined?(CryptoStat::VERSION)
    assert_match /\d+\.\d+\.\d+/, CryptoStat::VERSION
  end

  def test_api_client_class_exists
    assert defined?(CryptoStat::ApiClient)
  end

  def test_analyzer_class_exists
    assert defined?(CryptoStat::Analyzer)
  end

  def test_portfolio_calculator_class_exists
    assert defined?(CryptoStat::PortfolioCalculator)
  end

  def test_chart_drawer_class_exists
    assert defined?(CryptoStat::ChartDrawer)
  end

  def test_error_class_exists
    assert defined?(CryptoStat::Error)
    assert CryptoStat::Error < StandardError
  end

  def test_full_workflow_with_sample_data
    api = CryptoStat::ApiClient.new
    analyzer = CryptoStat::Analyzer.new
    portfolio = CryptoStat::PortfolioCalculator.new

    prices = SAMPLE_PRICES
    converted_prices = api.convert_prices(prices, 'USD')

    report = analyzer.build_report_text(converted_prices, 'USD')
    assert_includes report, "Текущая цена:"

    investment_result = portfolio.calculate_investment(converted_prices, 100)
    assert_includes investment_result, "Вложив"
  end

  def test_multi_currency_workflow
    api = CryptoStat::ApiClient.new
    analyzer = CryptoStat::Analyzer.new
    prices = SAMPLE_PRICES

    ['USD', 'EUR', 'RUB'].each do |currency|
      converted = api.convert_prices(prices, currency)
      report = analyzer.build_report_text(converted, currency)

      assert_includes report, "Текущая цена:"
      assert report.length > 0
    end
  end
end
