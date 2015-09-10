class BetaSurvey < ActiveRecord::Base
  def self.parse_and_create_user(params)
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    unless User.find_by_email(email)
      user = User.create(first_name: first_name, last_name: last_name, email: email)
    end
  end

end
