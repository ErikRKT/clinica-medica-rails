class Consultum < ApplicationRecord
  belongs_to :medico
  belongs_to :paciente

  # Validações
  validates :medico_id, :paciente_id, :data_consulta, presence: true
end
