class AddHowHeardToBetaSurveys < ActiveRecord::Migration
  def change
    add_column :beta_surveys, :how_heard, :text, array: true, default: []
  end
end
