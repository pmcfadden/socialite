class ApplicationController < ActionController::Base
  protect_from_forgery

  def about
  end

  protected
  def require_admin!
    puts "current user => #{current_user}, admin = #{current_user.try :admin}"
    raise "admins only" if !current_user.try :admin
  end
end
