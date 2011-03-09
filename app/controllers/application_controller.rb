class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_admin!, :only => [:admin]

  def about
  end

  def admin
  end

  protected
  def require_admin!
    raise "admins only" if !current_user.try :admin
  end
end
