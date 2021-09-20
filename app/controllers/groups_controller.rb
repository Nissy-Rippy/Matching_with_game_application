class GroupsController < ApplicationController

  def index
    @groups = Group.all.order(created_at: :desc)
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
    @room = @group.room
    #byebug
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
    @group = Group.find_by(id: params[:group_id])
    @group.users << current_user
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def search
    @groups = Group.search(params[:group][:keywords])
    @keywords = params[:keywords]
    render :index
  end

 private

  def group_params
   params.require(:group).permit(:name,:introduction,:image,:genre)
  end

end
