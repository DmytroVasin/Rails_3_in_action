class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :find_states

  private

  def find_states
    @states = State.order("id DESC").all
  end

  def authorize_admin!
    authenticate_user! 
    unless current_user.admin?
      flash[:error] = "You must be an admin to do that."
      redirect_to root_path
    end
  end
end
