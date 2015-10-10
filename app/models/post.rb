class Post < ActiveRecord::Base
  include Slugalicious

  belongs_to :user
  slugged ->(post) { "#{post.title}" }

  default_scope { order('created_at DESC')}
  def to_param
    Rails.logger.debug("slug: #{slug}")
    slug
  end
end
