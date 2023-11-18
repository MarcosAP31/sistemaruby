class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :update, :destroy]
  
    def index
      @products = Product.all
    end
  
    def show
    end
  
    def new
      @product = Product.new
    end
  
    def create
        @product = Product.new(product_params)
      
        if @product.save
          # Adjunta la imagen si se proporcionó
          @product.image.attach(params[:product][:image]) if params[:product][:image].present?
          redirect_to products_path, notice: 'Product was successfully created.'
        else
          render :new
        end
    end
  
    def edit
    end
  
    def update
        if @product.update(product_params)
          # Elimina la imagen existente si se proporcionó un nuevo archivo
          @product.image.purge if params[:product][:image].present?
          # Adjunta la nueva imagen si se proporcionó
          @product.image.attach(params[:product][:image]) if params[:product][:image].present?
      
          redirect_to products_path, notice: 'Product was successfully updated.'
        else
          render :edit
        end
      end
  
    def destroy
        # Elimina la imagen asociada si existe
        @product.image.purge if @product.image.attached?
      
        # Elimina el producto
        @product.destroy
      
        redirect_to products_path, notice: 'Product was successfully destroyed.'
    end
  
    private
  
    def set_product
      @product = Product.find(params[:id])
    end
  
    def product_params
      params.require(:product).permit(:Description, :Category, :Amount, :PurchasePrice, :SalePrice, :Image)
    end
  end