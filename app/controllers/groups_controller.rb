class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
   @group = Group.new
  end
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
       redirect_to groups_path
    else
       render :new
    end
  end

  def join
    @group = Group.find_by(params[:id])
    @group.users << current_user
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end
  
 private

  def group_params
   params.require(:group).permit(:name,:introduction,:image)
  end
end
