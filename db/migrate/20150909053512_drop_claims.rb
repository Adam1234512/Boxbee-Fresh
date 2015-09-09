class DropClaims < ActiveRecord::Migration
  def change
    drop_table :claims
  end
end
