class BoardsController < ApplicationController
  before_action :set_board, only: [:edit, :update, :destroy]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: ('掲示板を作成しました')
    else
      flash[:danger] = '掲示板を作成できませんでした'
      # render[:new]
       render action: :new
    end
  end

    def show
      @board = Board.find(params[:id])
      @comment = Comment.new
      @comments = @board.comments.includes(:user).order(created_at: :desc)
    end

    def edit; end

    def update

      if @board.update(board_params)
        redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
      else
        flash.now['danger'] = t('defaults.message.not_updated', item: Board.model_name.human)
        render :edit
      end

    end

    def destroy
     @board.destroy!
     redirect_to boards_path, success: t('defaults.message.deleted', item: Board.model_name.human)
    end

    def bookmarks
      @bookmark_boards = current_user.bookmark_boards.includes(:user).order(created_at: :desc).page(params[:page])
    end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end

end
