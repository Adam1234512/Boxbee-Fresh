class Company < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest
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
      joins(:cities).where("cities.name LIKE ?", "%#{search}%")
    else
      none
    end
  end

  def self.parse_city(params)
    # needs to be updated for multiple cities
    Rails.logger.debug("params: #{params[:cities]}")
    location_categories = params[:cities].split(",")
    cities_object_array = []
    #Check to see if city exists
    city_match = City.where("cities.name LIKE ?", "%#{location_categories[0]}").where("cities.name LIKE ?", "%#{location_categories[1]}").where("cities.state LIKE ?", "%#{location_categories[2]}").first
    # if so, insert the matching city into the array
    Rails.logger.debug("city_match: #{city_match}")
    if city_match
      cities_object_array << city_match.first
    # if not, create a new one and insert into array
    else
      new_city = City.create(name: "#{location_categories[0]}", state: "#{location_categories[1]}", country: "#{location_categories[2]}")
      cities_object_array << new_city
    end
    return cities_object_array
  end
end
