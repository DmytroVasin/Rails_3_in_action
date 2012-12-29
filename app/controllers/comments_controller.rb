class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_ticket

  def create
    @comment = @ticket.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      flash[:error] = "Comment has not been created."
      redirect_to [@ticket.project, @ticket]
    end
  end

  private

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
