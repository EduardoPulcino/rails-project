class DecorationsController < ApplicationController
  before_action :authenticate_user!, except: %i[ grouped index show ]
  before_action :set_decoration, only: %i[ show edit update destroy download_photos ]
  before_action :set_event_types, only: %i[ grouped index create ]
  before_action :set_search_filter, only: %i[ index grouped specific ]
  before_action :authenticate_admin, only: %i[ edit update destroy new create download_photos ]

  def grouped
  end

  def specific
    id = params[:event_type_id]
    @event_type = EventType.find(id)
    @decorations_specific = Decoration.find_by_event_type_id(id)
    @decorations_specific = @decorations_specific.search(@search) if @search.present?

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
    @decorations = Decoration.search(@search)

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

  def download_photos
    unless @decoration.photos.attached?
      redirect_to decoration_path(@decoration), alert: "Esta decoração não possui fotos para download."
      return
    end

    zip_filename = "#{@decoration.name.parameterize}-fotos.zip"
    buffer = Zip::OutputStream.write_buffer do |zip|
      used_names = {}

      @decoration.photos.each do |photo|
        entry_name = photo.filename.to_s
        if used_names[entry_name]
          used_names[entry_name] += 1
          base = File.basename(entry_name, File.extname(entry_name))
          ext = File.extname(entry_name)
          entry_name = "#{base}-#{used_names[entry_name]}#{ext}"
        else
          used_names[entry_name] = 1
        end

        zip.put_next_entry(entry_name)
        zip.write(photo.download)
      end
    end

    buffer.rewind
    send_data buffer.read, filename: zip_filename, type: "application/zip", disposition: "attachment"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decoration
      @decoration = Decoration.find(params[:id])
    end

    def set_event_types
      @event_types = EventType.includes(:decorations).all
    end

    def set_search_filter
      @search = params[:search].to_s.strip
      @filtered_ids = @search.present? ? Decoration.search(@search).pluck(:id).to_set : nil
    end

    # Only allow a list of trusted parameters through.
    def decoration_params
      params.require(:decoration).permit(:name, :event_type_id, photos: [])
    end
end
