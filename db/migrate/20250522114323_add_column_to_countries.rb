class AddColumnToCountries < ActiveRecord::Migration[7.1]
  def change
    add_column :countries, :capital_city, :string
  end
end
