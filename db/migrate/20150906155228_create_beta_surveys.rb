class CreateBetaSurveys < ActiveRecord::Migration
  def change
    create_table :beta_surveys do |t|
      t.boolean :currently_offer_storage
      t.string :how_manage_warehouse
      t.boolean :offer_transport
      t.string :how_manage_vehicles
      t.string :how_bookings_done
      t.string :company_name
      t.string :company_website
      t.string :name
      t.string :preferred_contact_method

      t.timestamps null: false
    end
  end
end
