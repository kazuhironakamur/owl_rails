require 'json'

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  protect_from_forgery :except => [:new]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.paginate(page: params[:page], per_page: 100)
    # @products.each{|p|
    #   json = Net::HTTP.get('192.168.151.120', "/hinjancd/#{p.code}", 3000)
    #   result = JSON.parse(json)
    #   p.jan = result[0]["jsjancd"] unless result.blank?
    # }

  end
  
  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    logger.debug params
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def filter
    p = request.query_parameters
    p.delete("utf8")
    p.delete("commit")
    unless p.length == 0 then
      @products = Product.all.paginate(page: params[:page], per_page: 100)
      @products = @products.where("code like ?", "%#{params[:code]}%") unless params[:code].blank?
      @products = @products.where("catchcopy like ?", "%#{params[:catchcopy]}%") unless params[:catchcopy].blank?
      @products = @products.where("weight_g like ?", "%#{params[:weight_g]}%") unless params[:weight_g].blank?
      
      unless params[:name].blank?
        c = []

        params[:name].gsub('　', ' ').split(' ').each{|n|
          result = JSON.parse(
            Net::HTTP.get('rrrapi.dad-way.local', "/hinmta/filter?hinnma=#{n}", 80)
          )
          result.each{|r| c.push(r['hincd'].strip) }
        }
        @products = @products.where(code: c)
        p @products
      end

      unless params[:brand_code].blank?
        c = []

        params[:brand_code].each{|b|
          result = JSON.parse(
            Net::HTTP.get('rrrapi.dad-way.local', "/hinmta/filter?hinclbid=#{b}", 80)
          )
          result.each{|r| c.push(r['hincd'].strip) }
        }

        @products = @products.where(code: c)
      end
    else
      @products = Product.all.paginate(page: params[:page], per_page: 100)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:code, :catchcopy, :weight_g)
    end
end
