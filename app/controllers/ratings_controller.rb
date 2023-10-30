# app/controllers/ratings_controller.rb
class RatingsController < ApplicationController
  before_action :set_topic
  before_action :set_post

  def create
    @rating = @post.ratings.build(rating_params)

    if @rating.save
      redirect_to topic_post_path(@topic, @post), notice: "Rating was successfully created."
    else
      redirect_to  topic_post_path(@topic, @post), alert: "Failed to create rating."
    end
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = @topic.posts.find(params[:post_id])
  end

  def rating_params
    params.require(:rating).permit(:value)
  end
end
