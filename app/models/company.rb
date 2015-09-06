class Company < ActiveRecord::Base
  belongs_to :user
  belongs_to :guest
  mount_uploader :logo, LogoUploader

  def self.search(search)
    if search
      where('city LIKE ?', "%#{search}%")
    else
      # scoped
    end
  end
end
