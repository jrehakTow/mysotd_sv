class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]


  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.where(user_id: current_user.id)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    #@category = Category.find(param)
    @items = Item.where(category_id: params[:id])
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @categories = Category.where(user_id: current_user.id)

    respond_to do |format|
      if @categories.count == 1
        format.html {redirect_to categories_url, alert: 'Cannot delete last category'}
        format.json { render json: @category.errors, status: :unprocessable_entity }
      elsif @category.destroy
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to categories_url, alert: 'Category is assigned to an item.'  }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name).merge(user_id: current_user.id)
    end
end
