class RemoveIndexFromCompanies < ActiveRecord::Migration
  def change
    remove_index :companies, :rank
  end
end
