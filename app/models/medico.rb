class Medico < ApplicationRecord
  has_many :consultums
  has_many :paciente, through: :consultums

  # Validar
  validates :nome, :crm, :especialidade, presence: true
  validates :crm,
    presence: true,
    uniqueness: true,
    format: {
    with: /\ACRM-[A-Z]{2} \d{4,6}\z/,
    message: "deve estar no formato CRM-UF NÚMERO (ex: CRM-PI 12345)"
  }
end
