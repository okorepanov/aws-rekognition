class CreateMediaLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :media_labels do |t|
      t.references :media, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true
      t.integer :confidence, null: false

      t.timestamps
    end
  end
end
