class CreateCompaniesCities < ActiveRecord::Migration
  def change
    create_table :companies_cities do |t|
      t.belongs_to :company, index: true
      t.belongs_to :city, index: true
    end
  end
end
