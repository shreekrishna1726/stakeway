class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  private

  def user_must_be_active!
  end




  def authenticate_user!
      if !spree_user_signed_in?
        redirect_to login_path, :notice => 'Please Login or Sign Up.'
      end
    end
end
