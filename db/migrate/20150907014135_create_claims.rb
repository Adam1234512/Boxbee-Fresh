class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.boolean :successfully_claimed
      t.references :company, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
