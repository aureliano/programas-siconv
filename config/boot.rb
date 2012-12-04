# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)
STOPWORDS = File.read('stopwords').split "\n"
LAST_EXTRACTION_DATE = File.read('.data_extraction_date').strip
DAY = 24 * 60 * 60

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

##
# Enable devel logging
#
# Padrino::Logger::Config[:development] = { :log_level => :devel, :stream => :stdout }
# Padrino::Logger.log_static = true
#

def load_environment_vars
  return unless File.exist? '.env'
  File.open('.env', 'r') {|f| f.read }.each_line do |line|
    var = line.split '='
    ENV[var[0].strip] ||= var[1].strip
  end
end

##
# Add your before load hooks here
#
Padrino.before_load do
  # URI format => mongodb://<dbuser>:<dbpassword>@ds033187.mongolab.com:33187/heroku_app9631427

  DATABASE = case Padrino.env
    when :development then Mongo::MongoClient.new('localhost', 27017)['programas_siconv']
    when :production then Mongo::MongoClient.from_uri(ENV['MONGOLAB_URI'])['heroku_app9631427']
    when :test then Mongo::MongoClient.new('localhost', 27017)['programas_siconv']
  end
  
  load_environment_vars
end

##
# Add your after load hooks here
#
Padrino.after_load do
end

Padrino.load!
