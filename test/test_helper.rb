$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "crypto_stat"
require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

# Константы для тестирования
SAMPLE_PRICES = (1..365).map { |i| 100 + (i * 0.5) + rand(-5..5) }.freeze
SHORT_PRICES = (1..10).map { |i| 100 + rand(-5..5) }.freeze
