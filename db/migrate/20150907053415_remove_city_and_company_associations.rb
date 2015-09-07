class RemoveCityAndCompanyAssociations < ActiveRecord::Migration
  def change
    remove_column :companies, :zip, :string
    remove_column :cities, :company_id, :string
  end
end
