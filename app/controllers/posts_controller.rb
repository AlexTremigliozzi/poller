class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order('created_at DESC').all
    @categories = Category.all
    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @user_who_commented = current_user
    @comment = Comment.build_from( @post, @user_who_commented.id, "" )
    @categories = Category.all
    @selections = Selection.where(:post_id => @post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all
    @selections = Selection.all
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @categories = Category.all
    @selections = Selection.all
    # @post_user = User.all
    respond_to do |format|
      CategoryPost.create(:project_id => @post.id)
      if @post.save
        (User.all.uniq - [current_user]).each do |user|
          Notification.create(recipient: user, actor: current_user, action: "posted", notifiable: @post)
        end
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
    @categories = Category.all

    respond_to do |format|
      @post.user_id = current_user.id
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def category_search
    @selected_id = params[:cat]
    @post_sel = CategoryPost.where(:category_id => @selected_id)
  end

  def graphs
    @edges = CategoryPost.all
    @nodes = Post.all
    @cats = Category.all
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
      params.require(:post).permit(:title, :description, :user_id, :effectiveness, monitoring: [], category_ids: [])
    end
end
