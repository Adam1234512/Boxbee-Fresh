class Post < ActiveRecord::Base
  include Slugalicious

  attr_accessor :slug
  belongs_to :user
  slugged ->(post) { "#{post.title}" }

  def to_param
    slug
  end
end
