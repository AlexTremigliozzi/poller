class PostSelectionsController < ApplicationController
  before_action :set_post_selection, only: [:show, :edit, :update, :destroy]

  # GET /post_selections
  # GET /post_selections.json
  def index
    @post_selections = PostSelection.all
  end

  # GET /post_selections/1
  # GET /post_selections/1.json
  def show
  end

  # GET /post_selections/new
  def new
    @post_selection = PostSelection.new
  end

  # GET /post_selections/1/edit
  def edit
  end

  # POST /post_selections
  # POST /post_selections.json
  def create
    @post_selection = PostSelection.find_or_create_by({
      :selection_id => params[:post_selection][:selection_id],
      :post_id => params[:post_selection][:post_id]})
    if (params[:post_selection][:configure]=="delete")
      @post_selection.destroy
    else
      respond_to do |format|
        if @post_selection.save
          format.html { redirect_to @post_selection, notice: 'Post selection was successfully created.' }
          format.json { render :show, status: :created, location: @post_selection }
        else
          format.html { render :new }
          format.json { render json: @post_selection.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /post_selections/1
  # PATCH/PUT /post_selections/1.json
  def update
    @post_selection = PostSelection.find_or_create_by({
      :selection_id => params[:post_selection][:selection_id],
      :post_id => params[:post_selection][:post_id]})
    if (params[:post_selection][:configure]=="delete")
      @post_selection.destroy
    else
      respond_to do |format|
        if @post_selection.update(post_selection_params)
          format.html { redirect_to @post_selection, notice: 'Post selection was successfully updated.' }
          format.json { render :show, status: :ok, location: @post_selection }
        else
          format.html { render :edit }
          format.json { render json: @post_selection.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /post_selections/1
  # DELETE /post_selections/1.json
  def destroy
    @post_selection.destroy
    respond_to do |format|
      format.html { redirect_to post_selections_url, notice: 'Post selection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_selection
      @post_selection = PostSelection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_selection_params
      params.require(:post_selection).permit(:post_id, :selection_id, :configure)
    end
end
