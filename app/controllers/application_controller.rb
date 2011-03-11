class ApplicationController < ActionController::Base
  protect_from_forgery

  def about
  end

  protected
  def require_admin!
    raise "admins only" if !current_user.try :admin
  end
end
