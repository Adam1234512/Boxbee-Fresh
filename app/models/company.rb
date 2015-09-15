class Company < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :cities


  # image stuff
  attr_accessor :logo
  has_attached_file :logo, styles: {
    listing: '180x80>'
  }
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  def self.search(search)
    if search
      if search.match("^([a-zA-Z]+\s*)+,\s[a-zA-Z]+,\s([a-zA-Z]+\s*)+$")
        search_array = search.split(",")
        joins(:cities).where("cities.name LIKE ?", "%#{search_array[0]}%").where("cities.state LIKE ?", "%#{search_array[1]}%").where("cities.country LIKE ?", "%#{search_array[2]}%")
      else
        search = search.sub(/\s+\Z/, "")
        joins(:cities).where("cities.name LIKE ?", "%#{search}%")
      end
    else
      none
    end
  end

  def self.parse_cities(params)
    # Multiple cities
    cities = params.select {|city| city.match("cities\d*")}
    Rails.logger.debug("cities: #{cities}")
    cities.select! {|k,v| v.length>0}
    Rails.logger.debug("cities after select!: #{cities}")

    cities_object_array = []

    cities.each do |k,v|
      location_categories = v.split(",")
      Rails.logger.debug("location_categories: #{location_categories}")
      #Check to see if city exists
      if location_categories.length == 2
        #city, country
        city_match = City.where("cities.name LIKE ?", "%#{location_categories[0]}").where("cities.country LIKE ?", "%#{location_categories[1]}").first
        city_match ? cities_object_array << city_match : new_city = City.create(name: "#{location_categories[0]}", country: "#{location_categories[1]}")
      elsif location_categories.length == 3
        #city, state, country
        city_match = City.where("cities.name LIKE ?", "%#{location_categories[0]}").where("cities.state LIKE ?", "%#{location_categories[1]}").where("cities.country LIKE ?", "%#{location_categories[2]}").first
        city_match ? cities_object_array << city_match : new_city = City.create(name: "#{location_categories[0]}", state: "#{location_categories[1]}", country: "#{location_categories[2]}")
      elsif location_categories.length == 4
        #sublocality, city, state, country
        city_match = City.where("cities.sub_locality LIKE ?", "%#{location_categories[0]}").where("cities.name LIKE ?", "%#{location_categories[1]}").where("cities.name LIKE ?", "%#{location_categories[2]}").where("cities.state LIKE ?", "%#{location_categories[3]}").first
        Rails.logger.debug("city_match: #{city_match}")
        city_match ? cities_object_array << city_match : new_city = City.create(sub_locality: "#{location_categories[0]}", name: "#{location_categories[1]}", state: "#{location_categories[2]}", country: "#{location_categories[3]}")
      else
      end
    end
    return cities_object_array
  end

  def self.parse_and_create_user(params)
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    # be careful with this. The following lines could overwrite the user
    user_from_params = User.find_by_email(email)
    if user_from_params
      user = user_from_params
    else
      user = User.create(first_name: first_name, last_name: last_name, email: email)
    end
    return user
  end
end
