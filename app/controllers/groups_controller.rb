class GroupsController < ApplicationController
  def index
    @groups = Group.all.order(created_at: :desc)
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
    @room = @group.room
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    #Groupにカレントユーザーを入れている。
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def join
    @group = Group.find(params[:group_id])
    #取得したグループにカレントユーザーを<<を使って格納している
    @group.users << current_user
    redirect_to group_path(@group)
  end
#脱退機能
  def destroy
    #まず、グループを特定取得
    @group = Group.find(params[:id])
    #特定したグループにいる複数のユーザーの中からカランとユーザーのみを削除する
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  def search
    #user検索の方でkeywordの単語を使っていたため、keywordsと複数形にしている
    @groups = Group.search(params[:keywords])
    @keywords = params[:keywords]
    render :index
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image, :genre)
  end
end
