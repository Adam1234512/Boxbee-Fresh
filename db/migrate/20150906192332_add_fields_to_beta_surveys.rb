class AddFieldsToBetaSurveys < ActiveRecord::Migration
  def change
    add_column :beta_surveys, :how_manage_vehicles, :text, array: true, default: []
    add_column :beta_surveys, :how_bookings_done, :text, array: true, default: []
  end
end
