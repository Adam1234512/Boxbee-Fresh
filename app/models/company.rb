class Company < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :cities


  # image stuff
  attr_accessor :logo
  has_attached_file :logo, styles: {
    listing: '160x40>'
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
    cities.select! {|k,v| v.length>0}
    cities_object_array = []

    cities.each do |city|
      location_categories = city.split(",")[0].drop(1)
      #Check to see if city exists
      city_match = City.where("cities.name LIKE ?", "%#{location_categories[0]}").where("cities.name LIKE ?", "%#{location_categories[1]}").where("cities.state LIKE ?", "%#{location_categories[2]}").first
      # if so, insert the matching city into the array
      if city_match
        cities_object_array << city_match
      # if not, create a new one and insert into array
      else
        new_city = City.create(name: "#{location_categories[0]}", state: "#{location_categories[1]}", country: "#{location_categories[2]}")
        cities_object_array << new_city
      end
    end
    return cities_object_array.length == 1 ? cities_object_array[0] : cities_object_array
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
