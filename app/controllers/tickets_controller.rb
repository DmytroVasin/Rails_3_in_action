class TicketsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_project
  before_filter :find_ticket, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_create!, :only => [:new, :create]
  before_filter :authorize_update!, :only => [:edit, :update]
  before_filter :authorize_delete!, :only => :destroy

  def show
  end
  
  def new
    @ticket = @project.tickets.build
    # 3.times { @ticket.assets.build }
    @ticket.assets.build
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
    @project = Project.for(current_user).find(params[:project_id])
    
    rescue ActiveRecord::RecordNotFound
    
    flash[:alert] = "The project you were looking for could not be found."
    redirect_to root_path
  end

  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
    
    flash[:alert] = "You cannot create tickets on this project."
    redirect_to @project
    end
  end

  def authorize_update!
    if !current_user.admin? && cannot?(:"edit tickets", @project)
    
    flash[:alert] = "You cannot edit tickets on this project."
    redirect_to @project
    end
  end

  def authorize_delete!
    if !current_user.admin? && cannot?(:"delete tickets", @project)

    flash[:alert] = "You cannot delete tickets from this project."
    redirect_to @project
    end
  end


end
