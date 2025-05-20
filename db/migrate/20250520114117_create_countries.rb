class CreateCountries < ActiveRecord::Migration[7.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.float :price
      t.text :description
      t.string :main_language
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
