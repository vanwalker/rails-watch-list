class BookmarksController < ApplicationController
  before_action :set_list, only:[:new, :create]

  def new
    # we need @list in our `simple_form_for`
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    # we need `list_id` to associate bookmark with corresponding list
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Saved!'
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
