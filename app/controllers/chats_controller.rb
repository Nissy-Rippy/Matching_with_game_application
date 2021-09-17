class ChatsController < ApplicationController

  def show
      #ログインしている人じゃない人のユーザー情報獲得
     @user = User.find_by(params[:id])
     #pluckを使うことにより、現ユーザーが利用しているルーム番号を取得している。
     rooms = current_user.user_rooms.pluck(:room_id)
     #userに紐づくroomのデータを取得している
     user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
     #user_roomの情報が取得できない場合
     room = nil

    if user_rooms.nil?
      #roomのidを作る、部屋を作る
      @room = Room.new
      @room.save
      #作られたroom_idをつかって、2人分のuser_idを作る。＝現在ログインしている人と話し相手のユーザーのid
      UserRoom.create(user_id: current_user, room_id: @room_id)
      UserRoom.create(user_id: @user.id, room_id: @room_id)
    else
      #user_roomを取得できた場合。user_roomのデータを取得する。
      room = user_rooms.room
    end
    #このチャットはルームに基づくチャットという記述
      @chats = @room.chats
      @chat = Chat.new(room_id: @room.id)
  end

  def index
    #質問コーナー
    @group = Group.joins(:room).find_by(rooms: { id: params[:room_id] })
    #グループに紐づいているユーザー情報を取得
    @users = @group.users
    rooms = current_user.user_rooms.pluck(:room_id)
    #userに紐づくroomのデータを取得している
    user_rooms = nil
    @users.each do |user|
      user_rooms = UserRoom.find_by(user_id: user.id, room_id: rooms)
    end
    #user_roomの情報が取得できない場合
    if user_rooms.nil?
      #roomのidを作る、部屋を作る
      @room = Room.new
      @room.save
      
      UserRoom.create(user_id: current_user, room_id: @room_id)
       #作られたroom_idをつかって、参加人数分のuser_idを作る。＝　現在ログインしている人と話し相手のユーザーのid
      @users.each do |user|
        UserRoom.create(user_id: user.id, room_id: @room_id)
      end
    else
      #user_roomを取得できた場合。user_roomのデータを取得する。
    end
     @room = Room.find(params[:room_id])
    #このチャットはルームに基づくチャットという記述
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chats = current_user.chats.new(chat_params)
    @chats.save
  end

private

  def chat_params
    #部屋のid番号も必要
    params.require(:chat).permit(:message, :room_id)
  end
  
end
