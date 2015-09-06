class AddHowManageWarehouseToBetaSurveys < ActiveRecord::Migration
  def change
    add_column :beta_surveys, :how_manage_warehouse, :text, array: true, default: []
  end
end
