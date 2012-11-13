class Programa < ActiveRecord::Base
  belongs_to :orgao_executor,   :class_name => 'Concedente'
  belongs_to :orgao_mandatario, :class_name => 'Concedente'
  belongs_to :orgao_superior,   :class_name => 'Concedente'
  belongs_to :orgao_vinculado,  :class_name => 'Concedente'
end
