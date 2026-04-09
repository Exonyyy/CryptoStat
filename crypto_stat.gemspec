# frozen_string_literal: true

require_relative "lib/crypto_stat/version"

Gem::Specification.new do |spec|
  spec.name          = "crypto_stat"
  spec.version       = CryptoStat::VERSION
  spec.authors       = ["CryptoStat Team"]


  spec.summary       = "Ruby гем для анализа криптовалют с интерактивным интерфейсом"
  spec.description   = "CryptoStat - это Ruby гем для анализа криптовалют с поддержкой исторических данных, анализа трендов, расчета портфелей и интерактивного графического интерфейса. Поддерживает множество криптовалют (Биткоин, Эфириум, ТОН) и валют (USD, EUR, RUB)."
  spec.homepage      = "https://github.com/Exonyyy/CryptoStat"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Exonyyy/CryptoStat"
  spec.metadata["bug_tracker_uri"] = "https://github.com/Exonyyy/CryptoStat/issues"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(git|travis|circleci)|appveyor)})
    end
  end

  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "tk", ">= 0.1.0"

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters"
end
