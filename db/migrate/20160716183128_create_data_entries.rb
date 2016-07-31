class CreateDataEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :data_entries do |t|
      t.references :form, foreign_key: true
      t.jsonb :inputs

      t.timestamps
    end
  end
end
