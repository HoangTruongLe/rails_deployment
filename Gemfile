source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18.4'
gem 'puma', '~> 3.7'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise', '~> 4.3'
gem 'slim-rails', '~> 3.1', '>= 3.1.2'
gem 'therubyracer', '~> 0.12.3'
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
gem 'twitter-bootstrap-rails', '~> 4.0'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'devise-bootstrap-views'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'faker', '~> 1.8', '>= 1.8.4'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'
gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.1'
gem 'jquery-datetimepicker-rails', '~> 2.4', '>= 2.4.1.0' # go for the document here http://xdsoft.net/jqplugins/datetimepicker/
gem "paperclip", "~> 5.0.0"
gem 'enumerize', '~> 2.1', '>= 2.1.2'
gem 'seed-fu', '~> 2.3', '>= 2.3.6'
gem 'working_hours', '~> 1.1', '>= 1.1.3'
gem 'docx_replace', '~> 1.2'
gem 'rubyzip', '~> 1.2', '>= 1.2.1'
gem 'chatwork', '~> 0.4.1'
gem 'select2-rails', '~> 4.0', '>= 4.0.3'
gem 'figaro', '~> 1.1', '>= 1.1.1'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver', '~> 3.4', '>= 3.4.4'
  gem 'rack-mini-profiler', '~> 0.10.5'
  gem 'rubocop', '~> 0.49.1'
  gem 'bullet', '~> 5.6'
  gem 'rails_best_practices', '~> 1.15', '>= 1.15.7'
  gem 'capistrano', '~> 3.7', '>= 3.7.1'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-rbenv', '~> 2.1'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '~> 2.0', '>= 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
