class Company < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest


  # image stuff
  attr_accessor :logo
  has_attached_file :logo, styles: {
    listing: '160x40>'
  }
  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  def self.search(search)
    if search
      where('city LIKE ?', "%#{search}%")
    else
      # scoped
    end
  end
end
