class AddSubLocalityToCities < ActiveRecord::Migration
  def change
    add_column :cities, :sub_locality, :string
  end
end
