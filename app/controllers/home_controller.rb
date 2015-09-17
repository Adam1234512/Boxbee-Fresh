class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:admin]

  def index
  end

  def admin
    @companies = Company.all
    @companies_for_approval = Company.where(:hold=>true).count
    @beta_surveys = BetaSurvey.all
  end
end
