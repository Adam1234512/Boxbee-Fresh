namespace :posts do
  desc "TODO"
  task auto_delete: :environment do
    Post.where(status: :deleted).each do |p|
      if p.updated_at <= 5.days.ago
        p.delete
        Rails.logger.info("Post id #{p.id} was deleted")
      end
    end
  end

end
