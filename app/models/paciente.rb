class Paciente < ApplicationRecord
  has_many :consultums
  has_many :medico, through: :consultums

  # Validar
  validates :nome, :cpf, presence: true
  validates :cpf, uniqueness: true

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
