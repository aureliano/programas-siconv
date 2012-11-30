DataMapper.logger = logger
DataMapper::Property::String.length(255)

case Padrino.env
  when :development then DataMapper.setup(:default, :adapter => 'mongo', :database => 'programas_siconv')
  when :production then DataMapper.setup(:default, ENV['MONGOLAB_URI'])
  when :test then DataMapper.setup(:default, :adapter => 'mongo', :database => 'programas_siconv')
end

# mongodb://<dbuser>:<dbpassword>@ds033187.mongolab.com:33187/heroku_app9631427
