class Admin::PermissionsController < Admin::BaseController
  before_filter :find_user
  def index
    @ability = Ability.new(@user)
    @projects = Project.all
  end

  def update
    @user.permissions.clear
    params[:permissions].each do |id, permissions|
      project = Project.find(id)
      permissions.each do |permission, checked|
        Permission.create!( :user => @user,
                            :thing => project,
                            :action => permission)
        end
        # Permission.create!(:user_id => user.id, :thing_id => project.id, :action => "view", :thing_type => "Project")
    end
    flash[:notice] = "Permissions updated."
    redirect_to admin_user_permissions_path
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
