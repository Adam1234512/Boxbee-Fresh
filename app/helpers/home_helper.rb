module HomeHelper
  #Workable
  # def get_job_listings
  #   jobs_array = []
  #   results = HTTParty.get('http://www.workable.com/spi/v3/accounts/boxbee/jobs', query: {:state => "published"}, headers: {"Authorization" => "Bearer #{ENV['WORKABLE_TOKEN']}"})
  #   results["jobs"].each do |job|
  #     jobs_array << [job["title"], job["location"]["city"], job["url"]]
  #   end
  #   return jobs_array
  # end

end
