require "test_helper"

class AnalyzerTest < Minitest::Test
  def setup
    @analyzer = CryptoStat::Analyzer.new
  end

  def test_get_symbol_usd
    assert_equal '$', @analyzer.get_symbol('USD')
  end

  def test_get_symbol_eur
    assert_equal '€', @analyzer.get_symbol('EUR')
  end

  def test_get_symbol_rub
    assert_equal '₽', @analyzer.get_symbol('RUB')
  end

  def test_analyze_period_basic
    prices = [100, 110, 120, 115, 125]
    result = @analyzer.analyze_period(prices, 5)

    assert_equal 100.0, result[:min]
    assert_equal 125.0, result[:max]
    assert_equal 114.0, result[:avg]
    assert result[:trend].include?('Рост')
  end

  def test_analyze_period_downtrend
    prices = [100, 90, 80, 70, 60]
    result = @analyzer.analyze_period(prices, 5)

    assert_equal 60.0, result[:min]
    assert_equal 100.0, result[:max]
    assert_equal 80.0, result[:avg]
    assert result[:trend].include?('Падение')
  end

  def test_analyze_period_no_change
    prices = [100, 100, 100, 100]
    result = @analyzer.analyze_period(prices, 4)

    assert_equal 100.0, result[:min]
    assert_equal 100.0, result[:max]
    assert_equal 100.0, result[:avg]
    assert result[:trend].include?("Стабильно")
  end

  def test_analyze_period_partial_array
    prices = [100, 110, 120, 130, 140, 150]
    result = @analyzer.analyze_period(prices, 3)

    assert_equal 130.0, result[:min]
    assert_equal 150.0, result[:max]
  end

  def test_analyze_period_empty_array
    prices = []
    assert_raises ArgumentError do
      @analyzer.analyze_period(prices, 5)
    end
  end

  def test_analyze_period_invalid_days
    prices = [100, 110, 120]
    assert_raises ArgumentError do
      @analyzer.analyze_period(prices, 0)
    end

    assert_raises ArgumentError do
      @analyzer.analyze_period(prices, -1)
    end
  end

  def test_build_report_text_valid
    prices = SAMPLE_PRICES
    report = @analyzer.build_report_text(prices, 'USD')

    assert_includes report, "Текущая цена: $"
    assert_includes report, "7 ДНЕЙ"
    assert_includes report, "30 ДНЕЙ"
    assert_includes report, "1 ГОД"
    assert_includes report, "Средняя:"
    assert_includes report, "Мин:"
    assert_includes report, "Макс:"
  end

  def test_build_report_text_all_currencies
    prices = SAMPLE_PRICES
    
    report_usd = @analyzer.build_report_text(prices, 'USD')
    assert_includes report_usd, '$'

    report_eur = @analyzer.build_report_text(prices, 'EUR')
    assert_includes report_eur, '€'

    report_rub = @analyzer.build_report_text(prices, 'RUB')
    assert_includes report_rub, '₽'
  end

  def test_build_report_text_empty_prices
    assert_raises ArgumentError do
      @analyzer.build_report_text([], 'USD')
    end
  end

  def test_build_report_text_invalid_currency
    prices = SAMPLE_PRICES
    assert_raises ArgumentError do
      @analyzer.build_report_text(prices, 'XYZ')
    end
  end
end
