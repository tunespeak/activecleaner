source "https://rubygems.org"

# Specify your gem's dependencies in rethought.gemspec
gemspec

# Multi Gemfile testing
gem "appraisal"

# For Travis
gem "rake"

group :local do
  # Guard
  gem "guard-rspec", require: false
  gem "terminal-notifier-guard", require: false # OS X

  # Coverage
  gem "mutant"
  gem "mutant-rspec"

  # Quality
  gem "rubocop", ">= 0.30.1", require: false
end

# Documentation
gem "sdoc", require: false
