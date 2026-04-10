module CryptoStat
  class PortfolioCalculator
    def calculate_investment(prices, amount_invested)
      raise ArgumentError, "Массив цен пуст" if prices.empty?
      raise ArgumentError, "Сумма должна быть положительной" if amount_invested <= 0
      raise ArgumentError, "Недостаточно исторических данных (нужно минимум 365 дней)" if prices.length < 365

      price_1_year_ago = prices.first
      current_price = prices.last

      raise ArgumentError, "Начальная цена не может быть нулевой" if price_1_year_ago.zero?

      coins_bought = amount_invested.to_f / price_1_year_ago
      current_value = coins_bought * current_price
      profit = current_value - amount_invested

      if profit > 0
        "Вложив #{amount_invested}, сейчас вы бы имели #{current_value.round(2)}\nПрибыль: +#{profit.round(2)} 🤑"
      else
        "Вложив #{amount_invested}, сейчас вы бы имели #{current_value.round(2)}\nУбыток: #{profit.round(2)} 😭"
      end
    end

    def calculate_roi(prices, amount_invested)
      raise ArgumentError, "Массив цен пуст" if prices.empty?
      raise ArgumentError, "Сумма должна быть положительной" if amount_invested <= 0

      price_1_year_ago = prices.first.to_f
      current_price = prices.last.to_f

      return 0.0 if price_1_year_ago.zero?

      ((current_price - price_1_year_ago) / price_1_year_ago * 100).round(2)
    end
  end
end
