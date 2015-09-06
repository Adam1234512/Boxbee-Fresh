class Guest < ActiveRecord::Base
  has_one :company
end
