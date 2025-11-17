class DecorationsController < ApplicationController
  before_action :authenticate_user!, except: %i[ grouped index show ]
  before_action :set_decoration, only: %i[ show edit update destroy ]
  before_action :set_event_types, only: %i[ grouped index create ]
  before_action :authenticate_admin, only: %i[ edit update destroy new create ]

  def grouped
  end

  def specific
    id = params[:event_type_id]
    @event_type = EventType.find(id)

    @decorations_specific = Decoration.find_by_event_type_id(id)

    respond_to do |format|
      format.html
      format.json { 
      render json: @decorations_specific.map { |decoration| 
        {
          id: decoration.id,
          name: decoration.name,
          photo: url_for(decoration.photos.first),
        }
      }, status: :ok }
    end
  end

  # GET /decorations or /decorations.json
  def index
    @decoration = Decoration.new
    @decorations = Decoration.all

    respond_to do |format|
      format.html
      format.json { render json: @decorations, status: :ok }
    end
  end

  # GET /decorations/1 or /decorations/1.json
  def show
    @event_type = EventType.find(@decoration.event_type_id)
  end

  # GET /decorations/1/edit
  def edit
    respond_to do |format|
      format.html
      format.turbo_stream { render partial: "decorations/form", locals: { decoration: @decoration }, formats: [:html] }
    end
  end

  # POST /decorations or /decorations.json
  def create
    @decoration = Decoration.new(decoration_params)

    respond_to do |format|
      if @decoration.save
        format.html { redirect_to decoration_url(@decoration), notice: t("flash.decorations.create.success") }
        format.json { render :show, status: :created, location: @decoration }
      else
        flash.now[:alert] = @decoration.errors.full_messages
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @decoration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /decorations/1 or /decorations/1.json
  def update
    respond_to do |format|
      if @decoration.update(decoration_params)
        format.html { redirect_to decoration_url(@decoration), notice: t("flash.decorations.update.success") }
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
      format.html { redirect_to decorations_url, notice: t("flash.decorations.destroy.success") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decoration
      @decoration = Decoration.find(params[:id])
    end

    def set_event_types
      @event_types = EventType.includes(:decorations).all
    end

    # Only allow a list of trusted parameters through.
    def decoration_params
      params.require(:decoration).permit(:name, :event_type_id, photos: [])
    end
end
