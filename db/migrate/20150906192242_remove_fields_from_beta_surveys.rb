class RemoveFieldsFromBetaSurveys < ActiveRecord::Migration
  def change
    remove_column :beta_surveys, :how_manage_vehicles, :string
    remove_column :beta_surveys, :how_bookings_done, :string
  end
end
