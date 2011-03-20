class LogosController < ApplicationController
  before_filter :require_admin!

  # POST /logo
  # POST /logo.xml
  def create
    @logo = Logo.new(params[:logo])

    respond_to do |format|
      if @logo.save
        format.html { redirect_to(new_logo_url, :notice => 'The new logo was uploaded.') }
      else
        flash[:alert] = @logo.errors
        format.html { render :action => "new" }
      end
    end
  end

end
