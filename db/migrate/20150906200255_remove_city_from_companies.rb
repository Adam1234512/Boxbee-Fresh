class RemoveCityFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :city, :string
  end
end
