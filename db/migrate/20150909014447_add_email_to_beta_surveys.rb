class AddEmailToBetaSurveys < ActiveRecord::Migration
  def change
    add_column :beta_surveys, :email, :string
  end
end
