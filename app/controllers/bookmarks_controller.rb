class BookmarksController < ApplicationController
  # def create
  #   @board = Board.find(params[:board_id])
  #   @bookmark = Bookmark.create(user_id: current_user.id, board_id: params[:board_id])
  #   redirect_to boards_path, success: ('ブックマークしました')
  # end

  # def destroy
  #   @board = Board.find(params[:board_id])
  #   @bookmark = Bookmark.find_by(user_id: current_user.id, board_id: @board.id)
  #   @bookmark.destroy
  #   redirect_to boards_path, success: ('ブックマークを解除しました')
  # end
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)
    # redirect_back fallback_location: root_path, success: t('.success')
  end

  def destroy
    @board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(@board)
    # redirect_back fallback_location: root_path, success: t('.success')
  end

end
