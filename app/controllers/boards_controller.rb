class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
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

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

end
