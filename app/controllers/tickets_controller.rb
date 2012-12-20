class TicketsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_project
  before_filter :find_ticket, only: [:show, :edit, :update, :destroy]

  def show
  end
  
  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(params[:ticket])
    @ticket.user = current_user
    if @ticket.save 
      flash[:success] = "Ticket has been created"
      redirect_to [@project, @ticket]
      # or use:  project_ticket_path(@project, @ticket)
    else
      flash[:error] = "Ticket has not been created"
      render 'new'
    end
  end

  def edit  
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:success] = "Ticket has been updated."
      redirect_to [@project, @ticket]
      # or use:  project_ticket_path(@project, @ticket)
    else
      flash[:error] = "Ticket has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:success] = "Ticket has been deleted."
    redirect_to project_path(@project.id)
  end

  private
  def find_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end