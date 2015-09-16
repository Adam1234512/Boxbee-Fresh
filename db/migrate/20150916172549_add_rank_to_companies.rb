class AddRankToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :rank, :int
    add_index :companies, :rank, :unique => true
  end
end
