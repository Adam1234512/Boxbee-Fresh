class RegistrationsController < Devise::RegistrationsController
  after_action :setup_account, only: :create

  private

  def setup_account
    return unless resource.persisted?
    c = guest_user.company
    c.user = resource
    c.save
  end

  protected

  #This method is only applicable when Devise confirmable is turned on.
  def after_inactive_sign_up_path_for(resource)
    if session[:beta_survey_id]
      Rails.logger.debug("Registrations controller has identified a beta_survey_id")
      root_path
      flash[:notice] = "You successfully added your company"
    else
      Rails.logger.debug("Registrations controller has NOT identified a beta_survey_id")
      flash[:notice] = "You successfully added your company"
      beta_program_path
    end
  end

  def after_sign_up_path_for(resource)
    if session[:beta_survey_id]
      Rails.logger.debug("Registrations controller has identified a beta_survey_id")
      root_path
      flash[:notice] = "You successfully added your company"
    else
      Rails.logger.debug("Registrations controller has NOT identified a beta_survey_id")
      beta_program_path
    end
  end
  # def after_sign_up_path_for(resource)
  #   if session[:company_id]
  #     # find the current_user
  #     # associate the company_id with them
  #     # give the path to send them to
  #   else
  #     root_path
  #   end
  #   '/an/example/path' # Or :prefix_to_your_route
  # end
  #
  # def after_inactive_sign_up_path_for(resource)
  #   # repeat from above
  #   '/an/example/path' # Or :prefix_to_your_route
  # end
end
