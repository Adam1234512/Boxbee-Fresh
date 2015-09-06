class AddGuestToCompany < ActiveRecord::Migration
  def change
    add_reference :companies, :guest, index: true, foreign_key: true
  end
end
