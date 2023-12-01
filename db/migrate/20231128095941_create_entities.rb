class CreateEntities < ActiveRecord::Migration[7.0]
  def change
    create_table :entities do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :service, null: false
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
