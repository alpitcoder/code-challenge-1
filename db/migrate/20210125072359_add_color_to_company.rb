class AddColorToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :color, :string
  end
end
