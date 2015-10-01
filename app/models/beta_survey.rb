class BetaSurvey < ActiveRecord::Base
  require 'httparty'
  default_scope {order('created_at DESC')}

  def self.parse_and_create_user(params)
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    user = User.find_by_email(email)
    unless user
      user = User.create(first_name: first_name, last_name: last_name, email: email)
    end
    return user
  end

  def self.create_capsule_contact(beta_survey)
    builder = {
      person: {
        contacts: {
          email: {
            type: 'work',
            emailAddress: beta_survey.email
          },
          website: {
            type: 'work',
            webService: 'URL',
            webAddress: beta_survey.company_website
          },
        },
        firstName: beta_survey.first_name,
        lastName: beta_survey.last_name,
        organisationName: beta_survey.company_name
      }
    }
    b = builder[:person].to_xml(root: :person).gsub!(/\"/, '\'').gsub!(/\n/, '')
    result = HTTParty.post("https://boxbee.capsulecrm.com/api/person", body: b, basic_auth: {:username=> ENV['CAPSULE_TOKEN'], :password => "x"}, headers: {'Content-type' => 'application/xml'})
    Rails.logger.debug("result of HTTParty: #{result}")
  end

  def self.put_capsule_custom_fields(beta_survey)
    Rails.logger.debug("beta survey path: #{Rails.application.routes.url_helpers.beta_survey_url(beta_survey, host: 'boxbee.com')}")
    person_match = HTTParty.get("https://boxbee.capsulecrm.com/api/party?email=#{beta_survey.email}", basic_auth: {:username=> ENV['CAPSULE_TOKEN'], :password => "x"})
    h = Hash.from_xml(person_match.body)['parties']
    Rails.logger.debug("size: #{h['size']}")
    if h['size'].to_i == 1
      id = h['person']['id']
    else
      id = h['person'].first['id']
    end
    Rails.logger.debug("id: #{id}")
    builder = {
      customFields: {
        customField: [{
          label: "Beta Survey Link",
          text: Rails.application.routes.url_helpers.beta_survey_url(beta_survey, host: 'boxbee.com')
        },
        {
          label: "How Heard",
          text: beta_survey.how_heard.select{|a| a!='0'}.join(", ")
        }]
      }
    }
    Rails.logger.debug("builder: #{builder}")
    b = builder[:customFields][:customField].to_xml(root: :customFields).gsub!(/\"/, '\'').gsub!(/\n/, '')
    result = HTTParty.put("https://boxbee.capsulecrm.com/api/party/#{id}/customfields", body: b, basic_auth: {:username=> ENV['CAPSULE_TOKEN'], :password => "x"}, headers: {"Content-type" => "application/xml"})
    Rails.logger.debug("result: #{result}")
  end

end
