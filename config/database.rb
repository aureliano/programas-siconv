DataMapper.logger = logger
DataMapper::Property::String.length(255)

case Padrino.env
  when :development then DataMapper.setup(:default, :adapter => 'mongo', :database => 'programas_siconv')
  when :production then DataMapper.setup(:default, :adapter => 'mongo', :database => 'programas_siconv')
  when :test then DataMapper.setup(:default, :adapter => 'mongo', :database => 'programas_siconv')
end
