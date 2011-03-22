class SubmissionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :best_of]

  def best_of
    @submissions = Submission.best_of.page params[:page]
  end

  def most_recent
    @submissions = Submission.most_recent.page params[:page]
  end

  # POST /submissions/1/vote_up
  def vote_up
    @submission = Submission.find(params[:id])
    @submission.vote_up current_user
  end
    
  # GET /submissions
  # GET /submissions.xml
  def index
    @submissions = Submission.list.page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.xml
  def show
    @submission = Submission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.xml
  def new
    @submission = Submission.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    assign_submission
  end

  def assign_submission
    if current_user.try :admin
      @submission = Submission.find(params[:id])
    else
      @submission = Submission.where(:user_id => current_user.id, :id => params[:id]).first
      raise "Could not find submission. Are you trying to edit someone else's?" if @submission.nil?
    end
  end

  # POST /submissions
  # POST /submissions.xml
  def create
    values = params[:submission].merge({:user => current_user})
    @submission = Submission.new(values)

    if Antispam.new.is_spam? @submission
      logger.warn "Submission was treated as spam"
      flash[:alert] = "Your submission was flagged as spam. Don't worry though. An administrator should allow your submission to be published soon."
      @submission.mark_as_spam
    else
       Antispam.new.train_as_content @submission
    end

    respond_to do |format|
      if @submission.save
        format.html { redirect_to(@submission, :notice => 'Your submission was received. Thanks.') }
        format.xml  { render :xml => @submission, :status => :created, :location => @submission }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /submissions/1
  # PUT /submissions/1.xml
  def update
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        format.html { redirect_to(@submission, :notice => 'Submission was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @submission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.xml
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to(submissions_url) }
      format.xml  { head :ok }
    end
  end
end
