class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :homepage
  skip_authorize_resource :only => :homepage
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order(:updated_at)
    @posts = Post.all
    @users = User.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.all
    @users = User.all
    @users = @users.joins("INNER JOIN posts ON users.id = posts.user_id")
    @users= @users.where("posts.id = " + params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
    @users = User.all
  end

  # GET /posts/1/edit
  def edit
    @posts = Post.all
    @users = User.all
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }

      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :desc, :user_id)
    end
end
