module CryptoStat
  class Analyzer
    def get_symbol(currency)
      case currency
      when 'RUB'
        '₽'
      when 'EUR'
        '€'
      else
        '$'
      end
    end

    def analyze_period(prices, days)
      raise ArgumentError, "Массив цен пуст" if prices.empty?
      raise ArgumentError, "Количество дней должно быть положительным" if days <= 0

      period = prices.last(days)

      min = period.min.round(2)
      max = period.max.round(2)
      avg = (period.sum / period.length).round(2)

      start_price = period.first.to_f
      end_price = period.last.to_f
      percent = if start_price.zero?
                  0.0
                else
                  (((end_price - start_price) / start_price) * 100).round(2)
                end

      trend = if percent > 0
                "Рост 📈 (+#{percent}%)"
              elsif percent < 0
                "Падение 📉 (#{percent}%)"
              else
                "Стабильно 🟩 (#{percent}%)"
              end

      { min: min, max: max, avg: avg, trend: trend }
    end

    def build_report_text(prices, currency)
      raise ArgumentError, "Массив цен пуст" if prices.empty?
      raise ArgumentError, "Неизвестная валюта: #{currency}" unless ['USD', 'EUR', 'RUB'].include?(currency)

      symbol = get_symbol(currency)
      week = analyze_period(prices, 7)
      month = analyze_period(prices, 30)
      year = analyze_period(prices, 365)

      text = "Текущая цена: #{symbol}#{prices.last.round(2)}\n\n"

      text += "--- 7 ДНЕЙ ---\n"
      text += "Средняя: #{symbol}#{week[:avg]} | #{week[:trend]}\n"
      text += "Мин: #{symbol}#{week[:min]} | Макс: #{symbol}#{week[:max]}\n\n"

      text += "--- 30 ДНЕЙ ---\n"
      text += "Средняя: #{symbol}#{month[:avg]} | #{month[:trend]}\n"
      text += "Мин: #{symbol}#{month[:min]} | Макс: #{symbol}#{month[:max]}\n\n"

      text += "--- 1 ГОД ---\n"
      text += "Средняя: #{symbol}#{year[:avg]} | #{year[:trend]}\n"
      text += "Мин: #{symbol}#{year[:min]} | Макс: #{symbol}#{year[:max]}\n"

      text
    end
  end
end
