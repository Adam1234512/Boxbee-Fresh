class AddHoldToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :hold, :boolean, default: true
  end
end
