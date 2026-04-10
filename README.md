# CryptoStat

Ruby gem для анализа криптовалют с графическим интерфейсом и полным тестовым покрытием.

## Возможности

- 📊 Получение исторических цен (365 дней) через CoinGecko API
- 📈 Анализ минимума/максимума/средней цены за периоды 7/30/365 дней
- 📉 Расчет тренда в процентах для каждого периода
- 💰 Расчет результата инвестиции "100$ год назад"
- 🌍 Поддержка валют: USD, EUR, RUB
- 🎨 Графический интерфейс на Tk с темной и светлой темами
- 📉 Визуализация цен за последние 30 дней
- ✅ Полное тестовое покрытие 

## Установка

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

### Запуск GUI приложения

```bash
ruby bin/crypto_app
```

## Структура проекта

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
├── crypto_stat.gemspec               # Спецификация гема
├── README.md                         # Документация
├── LICENSE                           # Лицензия 
└── .gitignore                        # Git configuration
```

## Запуск тестов

### Все тесты

```bash
bundle exec rake test
```

### тесты

- **Всего тестов**: 44+
- **ApiClient**: 6 тестов
- **Analyzer**: 13 тестов  
- **PortfolioCalculator**: 12 тестов
- **ChartDrawer**: 6 тестов
- **Интеграционные**: 7 тестов


## Команда

| Участник | Модуль | Описание |
| :--- | :--- | :--- |
| **Мартыненко Елизавета** | `crypto_app.rb` | Главное окно на Tk, выбор монет и валют, переключатель тем |
| **Сидоренко Артём** | `api_client.rb` | Получение данных с CoinGecko, конвертация цен |
| **Крива Егор** | `analyzer.rb` | Расчет статистики, определение тренда |
| **Кожатиков Глеб** | `chart_drawer.rb` | Визуализация графиков на холсте |
| **Акинин Юрий** | `portfolio.rb` | Расчет инвестиций, архитектура проекта |

## Разработка

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


## Лицензия
Проект лицензирован под MIT License.
