class Admin::StatesController < ApplicationController
  def index
    # @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(params[:state])
    
    if @state.save
      flash[:success] = "State has been created."
      redirect_to admin_states_path
    else
      flash[:error] = "State has not been created."
      render :action => "new"
    end
  end
end
