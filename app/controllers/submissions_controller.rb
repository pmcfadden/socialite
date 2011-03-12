class SubmissionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  # POST /submissions/1/vote_up
  def vote_up
    @submission = Submission.find(params[:id])
    @submission.vote_up current_user
  end
    
  # GET /submissions
  # GET /submissions.xml
  def index
    @submissions = Submission.where(:is_spam => false).page params[:page]

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
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.xml
  def create
    values = params[:submission].merge({:user => current_user})
    @submission = Submission.new(values)

    if Antispam.new.is_spam? @submission
      logger.warn "Submission was treated as spam"
      flash[:alert] = "Your submission was flagged as spam. Don't worry though. An administrator will soon allow your submission to be published."
      @submission.mark_as_spam
    else
       Antispam.new.train_as_content @submission
    end

    respond_to do |format|
      if @submission.save
        format.html { redirect_to(@submission, :notice => 'Submission was successfully created.') }
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
