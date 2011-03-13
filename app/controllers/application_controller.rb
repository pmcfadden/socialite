class ApplicationController < ActionController::Base
  protect_from_forgery

  def about
  end

  def sign_in_then_redirect
    flash[:alert] = "Please sign in first."
    session[:last_get_url] = params[:current_url]
    redirect_to new_session_url(:user)
  end

  def after_sign_in_path_for resource_or_scope
    last_get_url = session[:last_get_url]
    if last_get_url.nil?
      return super
    end

    last_get_url
  end

  protected
  def require_admin!
    puts "current user => #{current_user}, admin = #{current_user.try :admin}"
    raise "admins only" if !current_user.try :admin
  end
end
