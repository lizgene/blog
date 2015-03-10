source 'https://rubygems.org'


gem 'rails', '4.1.5'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'devise'
gem 'bootstrap-sass', '~> 3.3.0.1'
gem 'autoprefixer-rails' #used with bootstrap-sass to add vendor prefixes automagically
gem "font-awesome-rails"
gem 'picasa', '~> 0.7.2'
gem "omniauth-google-oauth2"
gem 'delayed_job_active_record'
gem 'mandrill-api'
gem 'will_paginate-bootstrap'
gem 'aws-sdk'
gem "jquery-ui-rails"
gem "s3_direct_upload"
gem "mini_magick"
gem "fog"
gem "carrierwave"
gem 'dotenv'
gem 'dotenv-deployment', require: 'dotenv/deployment'
gem 'geocoder'

group :development do
  gem 'pry'
  gem 'pry-remote'
  gem 'spring'
  gem 'capistrano', '~> 3.2.0'
  gem 'capistrano-rvm'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.3'
end

group :development, :test do
  #Include dependent RSpec Repos to run tests against the master branch
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, :git => "git://github.com/rspec/#{lib}.git", :branch => 'master'
  end
end

gem 'rails_12factor', group: :production

gem 'sdoc', '~> 0.4.0',          group: :doc


ruby "2.1.5"