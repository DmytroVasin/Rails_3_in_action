class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_ticket

  def create
    if cannot?(:"change states", @ticket.project)
      params[:comment].delete(:state_id)
    end

    @comment = @ticket.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
Rails.logger.info '========================================================================================================================='
Rails.logger.info '========================================================================================================================='
Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
Rails.logger.info '========================================================================================================================='
Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
Rails.logger.info '========================================================================================================================='
Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

Rails.logger.info '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
      if can?(:tag, @ticket.project) || current_user.admin?
        @ticket.tag!(params[:tags])
      end
      
      flash[:success] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      @states = State.all
      flash[:error] = "Comment has not been created."
      # redirect_to [@ticket.project, @ticket]
      # @project.id not be exist... how i can create it in controller?
      render :template => "tickets/show"
    end
  end

  private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
