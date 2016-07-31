class CreateForms < ActiveRecord::Migration[5.0]
  def change
    create_table :forms do |t|
      t.string :name
      t.boolean :visible
      t.string :public_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
