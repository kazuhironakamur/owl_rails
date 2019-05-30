class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end 

  # GET /images/1/edit
  def edit
  end

  # POST /images  
  # POST /images.json
  def create
    origin_filename = params[:image][:upload_file].original_filename
    @image = Image.new(image_params)
    @image.extension = File.extname(origin_filename)
    @image.filename = origin_filename.gsub(@image.extension,'')
    @image.imagefile = params[:image][:upload_file].read

    logger.debug image_params
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    code = params[:image][:code]
    logger.debug image_params

    respond_to do |format|
      if params[:image][:upload_file] != nil
        origin_filename = params[:image][:upload_file].original_filename
        extension = File.extname(origin_filename)
        filename = origin_filename.gsub(extension,'')
        imagefile = params[:image][:upload_file].read
        if @image.update(:code => code, :filename => filename, :extension => extension, :imagefile => imagefile)
          format.html { redirect_to @image, notice: 'Image was successfully updated.' }
          format.json { render :show, status: :ok, location: @image }
        else
          format.html { render :edit }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      else
        if @image.update(:code => code)
          format.html { redirect_to @image, notice: 'Image was successfully updated.' }
          format.json { render :show, status: :ok, location: @image }
        else
          format.html { render :edit }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find_by(filename: params[:filename])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def imageonly
    logger.debug 'it imageonly'
    logger.debug params[:filename]
    @image = Image.find_by(filename: params[:filename])
    send_data @image.imagefile, :type => 'image/jpeg', :disposition => 'inline'
  end

  def search
    @images = Image.where('code LIKE ?', "%#{params[:code]}%")
    urls = Array.new
    @images.each{|image|
      url = 'http://localhost:3000/images/' + image.filename + '/imageonly'
      urls.push({'code' => "#{image.code}", 'url' => "#{url}"})
    }
    render json: urls
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find_by(filename: params[:filename])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:code, :filename, :imagefile)
  end

end
