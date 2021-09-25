class ChatsController < ApplicationController
  def show
    # ログインしている人じゃない人のユーザー情報獲得
    @user = User.find(params[:id])
    # pluckを使うことにより、現ユーザーが利用しているルーム番号を取得している。
    rooms = current_user.user_rooms.pluck(:room_id)
    # userに紐づくroomのデータを取得している
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # user_roomの情報が取得できない場合
    if user_rooms.nil?
      # roomのidを作る、部屋を作る
      @room = Room.new
      @room.save
      # 作られたroom_idをつかって、2人分のuser_idを作る。＝現在ログインしている人と話し相手のユーザーのid
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      # user_roomを取得できた場合。user_roomのデータを取得する。
      @room = user_rooms.room
    end
    # このチャットはルームに基づくチャットという記述
    @chats = Chat.includes(:user).where(room_id: @room.id)
    @chat = Chat.new(room_id: @room.id)
  end

  # グループチャットのアクション,routeを短くためにindexに書いています。
  def index
    @group = Group.find(params[:group_id])
    if @group.users.where(id: current_user.id).empty?
      redirect_to group_path(@group)
      return
    end
    # グループに紐づいているユーザー情報を取得
    @users = @group.users
    rooms = current_user.user_rooms.pluck(:room_id)
    # userに紐づくroomのデータを取得している、room_idとgroup_idについている。
    user_rooms = UserRoom.find_by(room_id: rooms, group_id: @group.id)
    # user_roomの情報が取得できない場合
    if user_rooms.nil?
      # roomのidを作る、部屋を作る
      @room = Room.new(group_id: @group.id)
      @room.save # saveのタイミングでroom_idがつくられる。

      # 作られたroom_idをつかって、参加人数分のuser_idを作る。＝　現在ログインしている人と話し相手のユーザーのid
      @users.each do |user|
        UserRoom.create(user_id: user.id, room_id: @room.id, group_id: @group.id)
      end
    else
      @room = @group.room
    end

    # このチャットはルームに基づくチャットという記述
    @chats = Chat.includes(:user).where(room_id: @room.id)
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    # 現在ログインしている人がチャットを製作した時のアクション
    @chats = current_user.chats.new(chat_params)
    @chats.save
  end

  private

  def chat_params
    # 部屋のid番号も必要
    params.require(:chat).permit(:message, :room_id)
  end
end
