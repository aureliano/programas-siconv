# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)
STOPWORDS = File.read('stopwords').split "\n"
DAY = 24 * 60 * 60

require 'yaml'
metadata = YAML.load_file 'metadata.yml'
LAST_EXTRACTION_DATE = (PADRINO_ENV == 'test') ? Time.now.strftime('%d/%m/%Y') : metadata['LAST_EXTRACTION_DATE']
APP_VERSION = metadata['APP_VERSION']
metadata = nil

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

##
# Add your before load hooks here
#
Padrino.before_load do
end

##
# Add your after load hooks here
#
Padrino.after_load do
end

Padrino.load!
