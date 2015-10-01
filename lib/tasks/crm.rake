namespace :crm do
  desc "Migrates over Beta Survey Applicants to Capsule CRM"
  task migrate_beta_applicants: :environment do
    require 'httparty'

    BetaSurvey.all.each do |member|
      # check to see if they are a contact
      unless already_member?(member.email)
        BetaSurvey.create_capsule_contact(member)
        BetaSurvey.put_capsule_custom_fields(member)
      end
    end
  end

  def already_member?(email)
    person_match = HTTParty.get("https://boxbee.capsulecrm.com/api/party?email=#{email}", basic_auth: {:username=> ENV['CAPSULE_TOKEN'], :password => "x"})
    h = Hash.from_xml(person_match.body)['parties']
    if h['size'].to_i > 0
      return true
      puts "#{email} is already a CRM member"
    else
      return false
      puts "#{email} is not yet a CRM member. Proceeding..."
    end
  end

end
