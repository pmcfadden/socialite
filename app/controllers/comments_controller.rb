class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    values = params[:comment].merge({:user => current_user})
    @comment = Comment.new values
    @comment.save

    respond_to do |format|
      format.html { render :partial => 'comments/comment', :locals => {:comment => @comment} }
    end
  end
end
