class RemoveHowManageWarehouse < ActiveRecord::Migration
  def change
    remove_column :beta_surveys, :how_manage_warehouse, :string
  end
end
