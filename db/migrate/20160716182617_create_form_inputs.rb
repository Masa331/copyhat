class CreateFormInputs < ActiveRecord::Migration[5.0]
  def change
    create_table :form_inputs do |t|
      t.string :title
      t.string :input_type
      t.references :form, foreign_key: true

      t.timestamps
    end
  end
end
