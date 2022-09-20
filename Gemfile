# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'active_storage_validations', '~> 0.9.8'
gem 'azure-storage-blob', '~> 2.0', require: false
gem 'bootsnap', '>= 1.4.4', require: false
gem 'bulma-rails', '~> 0.9.3'
gem 'devise'
gem 'inline_svg'
gem 'kaminari'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'pg', '~> 1.1'
gem 'premailer-rails'
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.2'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sass-rails', '>= 6'
gem 'sendgrid-ruby'
gem 'solargraph', '~> 0.46.0'
gem 'webpacker', '~> 5.0'

group :development, :test do
  # Debugging tool
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'pry-rails'
  gem 'rubocop', '1.25.1'
  gem 'rubocop-rails', '2.13.2'
  gem 'rubocop-rspec', '2.8.0'
  # Tests
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'pundit-matchers', '~> 1.7.0'
  gem 'rspec-rails', '~> 5.0.0'
end
group :test do
  gem 'capybara'
  gem 'shoulda-matchers', '~> 5.0'
end
group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
