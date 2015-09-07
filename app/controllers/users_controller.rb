class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @companies = current_user.companies
  end
end
