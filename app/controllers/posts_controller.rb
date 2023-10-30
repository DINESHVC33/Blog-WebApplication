class PostsController < ApplicationController

  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_topic , except: :all_posts
  include CanCan::ControllerAdditions
  load_and_authorize_resource
  # GET /posts or /posts.json
  def index
    @posts = @topic.posts.includes([:ratings]).all
  end
  def all_posts
    @posts=Post.includes([:topic],[:ratings]).page(params[:page]).per(3)
  end
  # GET /posts/1 or /posts/1.json
  def show
    @ratings = @post.ratings.group(:value).count
  end
  def mark_as_read
    @post = Post.find(params[:id])
    @post.mark_as_read(current_user) if user_signed_in?
    respond_to do |format|
      format.js
    end
  end
  # GET /posts/new
  def new
    @post = @topic.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_posts_path(@topic, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to topic_post_path(@topic,@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.tags.clear
    @post.ratings.destroy_all
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_posts_path(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :topic_id ,:image, tag_ids: [])
    end
end
