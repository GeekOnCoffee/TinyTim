require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'haml', '>= 3.1.4'
  gem 'haml-rails'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem "twitter-bootstrap-rails"
  gem "therubyracer"
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem "capybara", :group => [:development, :test]

group :test do
  gem "cucumber-rails", :require => false
  gem "capybara"
  gem "database_cleaner"
  gem 'fivemat'
  gem 'powder'
  gem 'syntax' #highlighting for the rSpec suite
  gem 'pickle' # cucumber steps for creating models https://github.com/ianwhite/pickle
  gem 'spork', '>= 1.0.0rc2'
  gem 'shoulda-matchers'
end

gem "github", ">= 0.7.0", :require => nil, :group => [:development]
guard_notifications = true
group :development do
  case HOST_OS
  when /darwin/i
    gem 'rb-fsevent'
    gem 'ruby_gntp' if guard_notifications
  when /linux/i
    gem 'libnotify'
    gem 'rb-inotify'
  when /mswin|windows/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu' if guard_notifications
  end
end

group :development do
  gem "guard-livereload"
  gem "yajl-ruby"
  gem "rack-livereload"
  gem "guard-bundler"
  gem "guard-test"
  gem "guard-cucumber"
  gem "guard-redis"
  gem "guard-resque"
  gem "guard-unicorn"
  gem "pry-rails"
  gem "git_remote_branch"
  gem "annotate", "~> 2.4.1.beta1" #gem 'annotate' #NOTE: jonk (08/30/2011) => you have to add "require 'rake'" to the top of the annotate.rb file in the gem which can be opened with $> bundle exec bundle open annotate
end

gem "redis"
gem "resque", :require => "resque/server"
gem 'resque_mailer' # deliver email async
gem "simple_form"
gem 'dynamic_form' #for custom messages without the database column
gem "split", :require => "split/dashboard"
gem "friendly_id"
gem 'acts_as_list'
gem 'cancan'
gem 'carrierwave'
gem 'whenever' # provides a clear syntax for writing and deploying cron jobs

# NOTE (2012-05-31) jonk => putting here so we can seed factory data to prod if necessary
gem 'factory_girl'
gem 'factory_girl_rails' #auto loads the factories for us
gem "faker" #needs to be in develompnet, not test block
