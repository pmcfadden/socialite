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

    # if a post request was saved in the session then we execute it -- see #save_post_before_authenticating
    execute_saved_post_request if session[:pre_sign_in_post]

    last_get_url
  end

  def execute_saved_post_request
    logger.info "Executing the saved POST request before redirecting" 

    begin 
      class_name = session[:pre_sign_in_post][:controller].capitalize + "Controller"
      controller_instance = class_name.constantize.new
      saved_params = session[:pre_sign_in_post][:params]
      current_request = request

      (class << controller_instance; self; end).send(:define_method, :request) do
          return current_request
      end
      (class << controller_instance; self; end).send(:define_method, :params) do
          return saved_params
      end

      controller_instance.send(session[:pre_sign_in_post][:action])
      flash[:notice] = flash[:pre_sign_in_notice] if flash[:pre_sign_in_notice]
    rescue
      logger.error "error occurred executed the saved POST request: #{$!}"
      flash[:alert] = $!.message
    ensure
      session[:pre_sign_in_post] = nil
    end
  end

  # this before filter will save an attempted post request for later execution after the user is authenticated
  def save_post_before_authenticating
    if request.post? and current_user.nil?
      session[:pre_sign_in_post] = {:controller => controller_name, :action => action_name, :params => params.dup}
    end
    
    authenticate_user!
  end

  protected
  def require_admin!
    raise "admins only" if !current_user.try :admin
  end
end
