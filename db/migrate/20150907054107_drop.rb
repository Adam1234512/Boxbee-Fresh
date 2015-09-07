class Drop < ActiveRecord::Migration
  def change
    drop_table :companies_cities do |t|
      t.belongs_to :company, index: true
      t.belongs_to :city, index: true
    end

    create_table :cities_companies do |t|
      t.belongs_to :company, index: true
      t.belongs_to :city, index: true
    end
  end
end
