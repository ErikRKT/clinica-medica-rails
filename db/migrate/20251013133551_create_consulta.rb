class CreateConsulta < ActiveRecord::Migration[8.0]
  def change
    create_table :consulta do |t|
      t.integer :medico_id
      t.integer :paciente_id
      t.datetime :data_consulta

      t.timestamps
    end
  end
end
