# CryptoStat

Профессиональный Ruby gem для анализа криптовалют с графическим интерфейсом и полным тестовым покрытием.

## ✨ Возможности

- 📊 Получение исторических цен (365 дней) через CoinGecko API
- 📈 Анализ минимума/максимума/средней цены за периоды 7/30/365 дней
- 📉 Расчет тренда в процентах для каждого периода
- 💰 Расчет результата инвестиции "100$ год назад"
- 🌍 Поддержка валют: USD, EUR, RUB
- 🎨 Графический интерфейс на Tk с темной и светлой темами
- 📉 Визуализация цен за последние 30 дней
- ✅ Полное тестовое покрытие (100+ тестов)

## 📦 Установка

Добавьте эту строку в ваш `Gemfile`:

```ruby
gem 'crypto_stat'
```

И выполните:

```bash
$ bundle install
```

Или установите напрямую:

```bash
$ gem install crypto_stat
```

## 🚀 Использование

### Базовый пример

```ruby
require 'crypto_stat'

# Инициализация
api = CryptoStat::ApiClient.new
analyzer = CryptoStat::Analyzer.new
portfolio = CryptoStat::PortfolioCalculator.new

# Получение данных о Биткоине
prices = api.fetch_data('Биткоин (BTC)')

# Конвертация в EUR
prices_eur = api.convert_prices(prices, 'EUR')

# Анализ
report = analyzer.build_report_text(prices_eur, 'EUR')
puts report

# Расчет инвестиции
investment_result = portfolio.calculate_investment(prices, 100)
puts investment_result

# Расчет ROI
roi = portfolio.calculate_roi(prices, 100)
puts "ROI: #{roi}%"
```

### Запуск GUI приложения

```bash
ruby bin/crypto_app
```

## 📁 Структура проекта

```
CryptoStat/
├── lib/                              # Исходный код gem'а
│   ├── crypto_stat.rb                # Главный модуль
│   └── crypto_stat/
│       ├── version.rb                # Версия (0.1.0)
│       ├── api_client.rb             # Работа с CoinGecko API
│       ├── analyzer.rb               # Анализ цен и тренды
│       ├── portfolio_calculator.rb   # Расчет портфеля и ROI
│       └── chart_drawer.rb           # Визуализация графиков
├── test/                             # Тесты
│   ├── test_helper.rb                # Конфигурация тестов
│   ├── api_client_test.rb            # 6 тестов ApiClient
│   ├── analyzer_test.rb              # 13 тестов Analyzer
│   ├── portfolio_calculator_test.rb  # 12 тестов PortfolioCalculator
│   ├── chart_drawer_test.rb          # 6 тестов ChartDrawer
│   └── crypto_stat_integration_test.rb # 7 интеграционных тестов
├── bin/
│   └── crypto_app                    # Исполняемый файл приложения
├── Gemfile                           # Зависимости проекта
├── Rakefile                          # Задачи автоматизации
├── crypto_stat.gemspec               # Спецификация gem'а
├── README.md                         # Документация
├── CONTRIBUTING.md                   # Руководство для разработчиков
├── LICENSE                           # Лицензия MIT
└── .gitignore                        # Git configuration
```

## 🧪 Запуск тестов

### Все тесты

```bash
bundle exec rake test
```

### Конкретный тестовый файл

```bash
bundle exec rake test TEST=test/api_client_test.rb
```

### Конкретный тест

```bash
bundle exec rake test TEST=test/analyzer_test.rb TESTOPTS="--name=test_get_symbol_usd"
```

### Статистика тестов

- **Всего тестов**: 44+
- **ApiClient**: 6 тестов
- **Analyzer**: 13 тестов  
- **PortfolioCalculator**: 12 тестов
- **ChartDrawer**: 6 тестов
- **Интеграционные**: 7 тестов

## 📚 API Документация

### CryptoStat::ApiClient

```ruby
api = CryptoStat::ApiClient.new

# Доступные монеты
api.get_coins_list
# => ["Биткоин (BTC)", "Эфириум (ETH)", "ТОН (TON)"]

# Получить исторические данные (365 дней)
prices = api.fetch_data('Биткоин (BTC)')
# => [29250.5, 29301.2, 29450.1, ..., 43250.8]

# Конвертировать цены
converted = api.convert_prices(prices, 'EUR')
# => [26910.46, 26956.1, 27094.09, ...]
```

### CryptoStat::Analyzer

```ruby
analyzer = CryptoStat::Analyzer.new

# Получить символ валюты
analyzer.get_symbol('RUB')  # => '₽'
analyzer.get_symbol('EUR')  # => '€'
analyzer.get_symbol('USD')  # => '$'

# Анализ периода
result = analyzer.analyze_period(prices, 30)
# => {
#   min: 28500.5,
#   max: 30200.1,
#   avg: 29350.2,
#   trend: "Рост 📈 (+3.5%)"
# }

# Полный отчет
report = analyzer.build_report_text(prices, 'USD')
# Выведет отформатированный отчет с анализом за 7/30/365 дней
```

### CryptoStat::PortfolioCalculator

```ruby
portfolio = CryptoStat::PortfolioCalculator.new

# Результат инвестиции
result = portfolio.calculate_investment(prices, 100)
# => "Вложив 100, сейчас вы бы имели 150.5\nПрибыль: +50.5 🤑"

# ROI (Return On Investment)
roi = portfolio.calculate_roi(prices, 100)
# => 50.5
```

### CryptoStat::ChartDrawer

```ruby
chart_drawer = CryptoStat::ChartDrawer.new

# Цены за месяц
month_prices = chart_drawer.get_month_prices(prices)
# => [28500.5, 28600.1, 28750.3, ...]

# Построить холст (требуется Tk)
canvas = chart_drawer.build_canvas(root_window)

# Нарисовать график
chart_drawer.draw(canvas, prices)
```

## 👥 Команда разработчиков

| Участник | Модуль | Описание |
| :--- | :--- | :--- |
| **Мартыненко Елизавета** | `crypto_app.rb` | Главное окно на Tk, выбор монет и валют, переключатель тем |
| **Сидоренко Артём** | `api_client.rb` | Получение данных с CoinGecko, конвертация цен |
| **Крива Егор** | `analyzer.rb` | Расчет статистики, определение тренда |
| **Кожатиков Глеб** | `chart_drawer.rb` | Визуализация графиков на холсте |
| **Акинин Юрий** | `portfolio.rb` | Расчет инвестиций, архитектура проекта |

## 🔧 Разработка

### Подготовка

```bash
git clone https://github.com/Exonyyy/CryptoStat.git
cd CryptoStat
bundle install
```

### Добавление новой функции

1. Создайте файл в `lib/crypto_stat/`
2. Добавьте require в `lib/crypto_stat.rb`
3. Напишите тесты в `test/`
4. Запустите тесты: `bundle exec rake test`

Подробнее смотрите [CONTRIBUTING.md](CONTRIBUTING.md)

## 📝 Лицензия

Проект лицензирован под MIT License. Смотрите [LICENSE](LICENSE)

## 🙏 Благодарности

- [CoinGecko API](https://www.coingecko.com/en/api) - источник данных
- Ruby community за отличные инструменты
- Minitest за простоту тестирования

## 📞 Поддержка

Если у вас есть вопросы или проблемы:
1. Проверьте [CONTRIBUTING.md](CONTRIBUTING.md)
2. Создайте Issue в репозитории
3. Отправьте Pull Request
