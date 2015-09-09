class AddFullNamesToBetaSurvey < ActiveRecord::Migration
  def change
    add_column :beta_surveys, :first_name, :string
    add_column :beta_surveys, :last_name, :string
    remove_column :beta_surveys, :name, :string
  end
end
