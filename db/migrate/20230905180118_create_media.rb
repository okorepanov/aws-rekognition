class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.text :description
      t.string :type, null: false
      t.boolean :analyzed, null: false, default: false
      t.boolean :safe, null: false, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
