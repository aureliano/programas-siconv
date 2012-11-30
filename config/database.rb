# URI format => mongodb://<dbuser>:<dbpassword>@ds033187.mongolab.com:33187/heroku_app9631427
# Utilizando código do método before_load em boot.rb

case Padrino.env
  when :development then Mongo::MongoClient.new('localhost', 27017)['programas_siconv']
  when :production then Mongo::MongoClient.from_uri(ENV['MONGOLAB_URI'])['programas_siconv']
  when :test then Mongo::MongoClient.new('localhost', 27017)['programas_siconv']
end
