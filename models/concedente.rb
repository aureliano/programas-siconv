class Concedente < ActiveRecord::Base
  has_one :orgao_superior, :class_name => 'Concedente', :foreign_key => 'orgao_superior'
end
