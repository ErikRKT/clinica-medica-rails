class Medico < ApplicationRecord
  has_many :consultums
  has_many :paciente, through: :consultums

  # Validar
  validates :nome, :crm, :especialidade, presence: true
  validates :crm, uniqueness: true
end