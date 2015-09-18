namespace :survey do
  desc "TODO"
  task import_csv: :environment do
    require 'csv'
    require 'date'
    file = File.join(Rails.root, 'lib', 'assets', 'google_beta_surveys.csv')
    entries = CSV.read(file, headers: true)
    entries.each do |entry|
      #puts entry[0].inspect
      # created_at
      created_at = DateTime.strptime(entry[0],"%m/%d/%Y %H:%M:%S")
      # currently_offer_storage
      currently_offer_storage = entry[1] == "Yes" ? true : false
      # offer_transport
      offer_transport = entry[3] == "Yes" ? true : false
      # company_name
      company_name = entry[6]
      # company_website
      company_website = entry[9]
      # preferred_contact_method
      preferred_contact_method = entry[8]
      # how_manage_warehouse
      !entry[2].nil? ? how_manage_warehouse = entry[2].split(",") : how_manage_warehouse = nil
      # how_manage_vehicles
      !entry[4].nil? ? how_manage_vehicles = entry[4].split(",") : how_manage_vehicles = nil
      # how_bookings_done
      !entry[5].nil? ? how_bookings_done = entry[5].split(",") : how_bookings_done = nil
      # email
      m = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/.match(entry[8])
      m ? email = m[0] : email = nil
      # first_name
      name = entry[7].split(" ")
      first_name = name[0]
      # last_name
      name.shift
      last_name = name.join("','")

      #Enter into DB
      betasurvey = BetaSurvey.create(created_at: created_at, currently_offer_storage: currently_offer_storage,
      offer_transport: offer_transport, company_name: company_name, company_website: company_website,
      preferred_contact_method: preferred_contact_method, how_manage_warehouse: how_manage_warehouse,
      how_bookings_done: how_bookings_done, email: email, first_name: first_name, last_name: last_name)

    end
  end

end
