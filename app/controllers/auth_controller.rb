class AuthController < ApplicationController
  before_action :check_user_fields



  private

  def check_user_fields
    if user_signed_in?
      if current_user.first_name.blank? || current_user.last_name.blank? || current_user.date_of_birth.blank?
        flash[:alert] = "Please complete your profile before continuing."
        redirect_to edit_user_registration_path
      end
    end
  end
  
end