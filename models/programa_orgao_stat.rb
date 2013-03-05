class ProgramaOrgaoStat
  include Mongoid::Document
  
  field :concedente, :type => String
  field :ano, :type => Integer
  field :total, :type => Integer
end
