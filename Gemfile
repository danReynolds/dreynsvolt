source 'https://rubygems.org'

gem 'volt', '0.8.21'

# The following gem's are optional for themeing

gem 'volt-foundation', '~> 0.0.4'
gem 'newrelic_rpm'

# Server for MRI
platform :mri do
  gem 'thin', '~> 1.6.0'
  gem 'bson_ext', '~> 1.9.0'
end

# Server for jruby
platform :jruby do
  gem 'jubilee'
end

#---------------------
# Needed at the moment
gem 'volt-sockjs', require: false, platforms: :mri
