class UserCommentRatingsController < ApplicationController

  def new
    @comment = Comment.find(params[:comment_id])
    @user_comment_rating = UserCommentRating.new
  end

  def create
    @comment = Comment.find(params[:user_comment_rating][:comment_id])
    user = current_user
    @user_comment_rating = user.user_comment_ratings.build(user_comment_rating_params)
    if @user_comment_rating.save
      redirect_to topic_post_comment_user_comment_ratings_path
    else
      flash[:error] = 'Rating could not be saved.'
      render 'index'
    end
  end

  def index
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
    @ratings = @comment.user_comment_ratings.includes([:user])
  end

  private

  def user_comment_rating_params
    params.require(:user_comment_rating).permit(:value, :comment_id)
  end
end