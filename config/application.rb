$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'perpetuity/mongodb'
require 'bson'
require 'virtus'
require 'active_model'
require 'time'

Bundler.require :default, ENV['RACK_ENV']

DB_NAME = 'marionette_blog' + '_' + ENV['RACK_ENV']

Perpetuity.data_source :mongodb, DB_NAME

require_relative '../decorators/decorators'
require_relative '../domaine/domaine'

require_relative '../api/api_require'

# Dir[File.expand_path('../../api/**/*.rb', __FILE__)].each { |f| require f }

require 'api'
