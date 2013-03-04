class ProgramaPeriodoStat
  include Mongoid::Document
  
  field :ano, :type => Integer
  field :mes, :type => Integer
  field :total, :type => Integer
end
