class Paciente < ApplicationRecord
  has_many :consultums
  has_many :medico, through: :consultums

  # Validar
  validates :nome, :cpf, presence: true
  validates :cpf,
            presence: true,   # Não pode ficar em branco
            uniqueness: true, # Não pode ter CPFs duplicados
            format: {
              with: /\A\d{3}\.\d{3}\.\d{3}-\d{2}\z/,
              message: "deve estar no formato 123.456.789-00"
            }
  require "csv"

  def self.to_csv
    attributes = %w[id nome cpf]

    CSV.generate(headers: true) do |csv|
      csv << attributes.map(&:capitalize)

      all.each do |paciente|
        csv << attributes.map { |attr| paciente.send(attr) }
      end
    end
  end
end
