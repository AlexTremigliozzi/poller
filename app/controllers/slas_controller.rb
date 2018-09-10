class SlasController < ApplicationController
  before_action :set_sla, only: [:show, :edit, :update, :destroy]

  # GET /slas
  # GET /slas.json
  def index
    @slas = Sla.all
  end

  # GET /slas/1
  # GET /slas/1.json
  def show
  end

  # GET /slas/new
  def new
    @sla = Sla.new
  end

  # GET /slas/1/edit
  def edit
  end

  # POST /slas
  # POST /slas.json
  def create
    @sla = Sla.new(sla_params)

    respond_to do |format|
      if @sla.save
        format.html { redirect_to @sla, notice: 'Sla was successfully created.' }
        format.json { render :show, status: :created, location: @sla }
      else
        format.html { render :new }
        format.json { render json: @sla.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slas/1
  # PATCH/PUT /slas/1.json
  def update
    respond_to do |format|
      if @sla.update(sla_params)
        format.html { redirect_to @sla, notice: 'Sla was successfully updated.' }
        format.json { render :show, status: :ok, location: @sla }
      else
        format.html { render :edit }
        format.json { render json: @sla.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slas/1
  # DELETE /slas/1.json
  def destroy
    @sla.destroy
    respond_to do |format|
      format.html { redirect_to slas_url, notice: 'Sla was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sla
      @sla = Sla.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sla_params
      params.require(:sla).permit(:sla1, :sla2, :diffnum)
    end
end
