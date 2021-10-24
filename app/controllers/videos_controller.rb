class VideosController < ApplicationController

  def index
    #with_attachedとincludesでactivestorageのn+1問題を解消している
    #has_one_attachedメソッドを使ってActive Storageにvideo
    #をアタッチメントしたことによりwith_attached_book_imageというスコープが作成される。with_attached_videoをallとして扱っている
    @videos = Video.with_attached_video.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
    @videos = @user.videoes.with_attached_video.order("created_at DESC")
  end

  def new
    @video = Video.new
  end

  #この記述によりjson形式であたいを返し、jbuilderを利用できるようにしている。
  def search
    @videos = Video.where("title like?", "%#{params[:key_word]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @videos = Video.find_by(id: params[:id])
  end

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if @video.save
      flash[:notice] = "動画投稿完了しました＾＾"
      redirect_to videos_path
    else
      render :new
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path
  end

private

  def video_params
    params.require(:video).permit(:title,:introduction,:video)
  end

end