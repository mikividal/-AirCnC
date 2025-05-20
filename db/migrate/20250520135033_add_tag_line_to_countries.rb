class AddTagLineToCountries < ActiveRecord::Migration[7.1]
  def change
    add_column :countries, :tag_line, :string
  end
end
