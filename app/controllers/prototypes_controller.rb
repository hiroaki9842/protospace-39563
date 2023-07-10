class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:edit,:new,:update]##update追加
  before_action :move_to_index, except: [:index,:new,:show]
  before_action :set_prototype, only: [:edit, :update]##

  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
    # 保存が成功した場合の処理
    redirect_to "/"
    else
    # 保存が失敗した場合の処理
    render :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    if current_user != @prototype.user##追加
      redirect_to root_path
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if  prototype.update(prototype_params)
        redirect_to prototype_path(prototype)
    else
        render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def set_prototype##追加
    @prototype = Prototype.find(params[:id])
  end
end