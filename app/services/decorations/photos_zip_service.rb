class Decorations::PhotosZipService
  Result = Struct.new(:filename, :content)

  def initialize(decoration)
    @decoration = decoration
  end

  def call
    return nil unless @decoration.photos.attached?

    buffer = build_zip_buffer
    buffer.rewind

    Result.new(zip_filename, buffer.read)
  end

  def build_zip_buffer
    Zip::OutputStream.write_buffer do |zip|
      used_names = {}

      @decoration.photos.each do |photo|
        entry_name = unique_entry_name(photo.filename.to_s, used_names)

        zip.put_next_entry(entry_name)
        zip.write(photo.download)
      end
    end
  end

 def unique_entry_name(entry_name, used_names)
    if used_names[entry_name]
      used_names[entry_name] += 1
      base = File.basename(entry_name, File.extname(entry_name))
      ext = File.extname(entry_name)
      "#{base}-#{used_names[entry_name]}#{ext}"
    else
      used_names[entry_name] = 1
      entry_name
    end
  end

  def zip_filename
    "#{@decoration.name.parameterize}-fotos.zip"
  end
end
