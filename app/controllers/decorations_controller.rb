class DecorationsController < ApplicationController
  before_action :authenticate_user!, except: %i[ grouped index show ]
  before_action :set_decoration, only: %i[ show edit update destroy ]
  before_action :authenticate_admin, only: %i[ edit update destroy new create ]

  def grouped
    @event_types = EventType.includes(:decorations).all
  end

  def specific
    id = params[:event_type_id]
    @event_type = EventType.find(id)

    @decorations_specific = Decoration.find_by_event_type_id(id)
  end

  # GET /decorations or /decorations.json
  def index
    @decorations = Decoration.all

    respond_to do |format|
      format.html
      format.json { render json: @decorations, status: :ok }
    end
  end

  # GET /decorations/1 or /decorations/1.json
  def show
  end

  # GET /decorations/new
  def new
    @decoration = Decoration.new
  end

  # GET /decorations/1/edit
  def edit
  end

  # POST /decorations or /decorations.json
  def create
    @decoration = Decoration.new(decoration_params)

    respond_to do |format|
      if @decoration.save
        format.html { redirect_to decoration_url(@decoration), notice: "Decoration was successfully created." }
        format.json { render :show, status: :created, location: @decoration }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @decoration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decorations/1 or /decorations/1.json
  def update
    respond_to do |format|
      if @decoration.update(decoration_params)
        format.html { redirect_to decoration_url(@decoration), notice: "Decoration was successfully updated." }
        format.json { render :show, status: :ok, location: @decoration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @decoration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decorations/1 or /decorations/1.json
  def destroy
    @decoration.destroy

    respond_to do |format|
      format.html { redirect_to decorations_url, notice: "Decoration was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decoration
      @decoration = Decoration.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def decoration_params
      params.require(:decoration).permit(:name, :event_type_id, :photo)
    end
end
