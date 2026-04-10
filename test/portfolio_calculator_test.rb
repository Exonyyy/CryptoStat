# frozen_string_literal: true

require_relative "test_helper"

module CryptoStat
  class PortfolioCalculatorTest < Minitest::Test
    def setup
      @calculator = PortfolioCalculator.new
      @year_prices = (1..365).map { |i| 50 + i * 0.1 }  # 365 дней, цена растет
    end

    # ============= Тесты для calculate_investment =============

    def test_calculate_investment_profit
      result = @calculator.calculate_investment(@year_prices, 1000)
      
      assert_includes result, "Прибыль: +"
      assert_includes result, "🤑"
    end

    def test_calculate_investment_loss
      falling_prices = (1..365).map { |i| 100 - i * 0.1 }
      result = @calculator.calculate_investment(falling_prices, 1000)
      
      assert_includes result, "Убыток: -"
      assert_includes result, "😭"
    end

    def test_calculate_investment_insufficient_data
      prices = (1..364).to_a
      
      error = assert_raises(ArgumentError) do
        @calculator.calculate_investment(prices, 1000)
      end
      assert_equal "Недостаточно исторических данных (нужно минимум 365 дней)", error.message
    end

    def test_calculate_investment_empty_prices
      error = assert_raises(ArgumentError) do
        @calculator.calculate_investment([], 1000)
      end
      assert_equal "Массив цен пуст!", error.message
    end

    def test_calculate_investment_zero_price
      prices = [0] + [100] * 364
      
      error = assert_raises(ArgumentError) do
        @calculator.calculate_investment(prices, 1000)
      end
      assert_equal "Начальная цена не может быть нулевой", error.message
    end

    # ============= Тесты для calculate_roi =============

    def test_calculate_roi_positive
      prices = [100] * 364 + [150]
      roi = @calculator.calculate_roi(prices, 1000)
      
      assert_equal 50.0, roi
    end

    def test_calculate_roi_negative
      prices = [100] * 364 + [75]
      roi = @calculator.calculate_roi(prices, 1000)
      
      assert_equal(-25.0, roi)
    end

    def test_calculate_roi_zero_change
      prices = [100] * 365
      roi = @calculator.calculate_roi(prices, 1000)
      
      assert_equal 0.0, roi
    end

    def test_calculate_roi_empty_prices
      error = assert_raises(ArgumentError) do
        @calculator.calculate_roi([], 1000)
      end
      assert_equal "Массив цен пуст", error.message
    end

    def test_calculate_roi_negative_amount
      error = assert_raises(ArgumentError) do
        @calculator.calculate_roi(@year_prices, -100)
      end
      assert_equal "Сумма должна быть положительной", error.message
    end
  end
end