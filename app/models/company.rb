class Company < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest
  has_and_belongs_to_many :cities
  has_many :claims


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

  def claimed?
    self.claims.where(successfully_claimed: true)
  end

  def claimed_by?(user)
    self.claimed?.where(user_id: user.id)
  end

  def self.parse_cities(params)
    cities_string = params[:company][:cities]
    cities_object_array = []
    cities_string.split(",").each do |city|
      cities_object_array << City.where("cities.name LIKE ?", "%#{city}%").first
    end
    return cities_object_array
  end
end
