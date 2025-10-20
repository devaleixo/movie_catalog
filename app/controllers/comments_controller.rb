class CommentsController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)
    if user_signed_in?
      @comment.user = current_user
      @comment.author_name = current_user.email
    end

    if @comment.save
      redirect_to movie_path(@movie)
    else
      redirect_to movie_path(@movie)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :author_name)
  end
end
