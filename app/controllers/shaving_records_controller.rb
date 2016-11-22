
class ShavingRecordsController < ApplicationController
  before_action :set_shaving_record, only: [:show, :edit, :update, :destroy, :get_items]
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  # GET /shaving_records
  # GET /shaving_records.json
  def index
    @shaving_records = ShavingRecord.where(user_id: current_user.id).order(sort_column + ' ' + sort_direction)
  end

  # GET /shaving_records/1
  # GET /shaving_records/1.json
  def show
    @shaving_record = ShavingRecord.find(params[:id])
    @shaving_items = ShavingItem.where(shaving_record_id: params[:id]).pluck(:item_id)
    @items = Item.where(id: @shaving_items)

    respond_to do |format| #this includes items!
      format.html
      format.json {render :json =>{:shaving_record => @shaving_record,
        :items => @items
        }
      }
      puts @shaving_record.to_json(:only =>[:id, :description, :rating])
      puts format.json
    end
  end

  # GET /shaving_records/new
  def new
    @shaving_record = ShavingRecord.new
    @item = Item.where(user_id: current_user.id, retired: false)
    @shaving_record.items = @item
    if @item.blank?
      redirect_to items_url, alert: 'Please add a shaving item to inventory.'
    end
  end

  # GET /shaving_records/1/edit
  def edit
    @shaving_items = ShavingItem.find_by_shaving_record_id(params[:id])
    puts @shaving_items

    @item = Item.where(user_id: current_user.id, retired: false)
  end

  # POST /shaving_records
  # POST /shaving_records.json
  def create
    @shaving_record = ShavingRecord.new(shaving_record_params)
    @shaving_items = params['shave_record'][:item_ids]
    respond_to do |format|
      if @shaving_record.save
        #create loop to add multiple items to shaving items
        @shaving_items.each do |item|
          shaving_item = ShavingItem.new
          @item = Item.find(item)
          shaving_item.shaving_record_id = @shaving_record.id
          shaving_item.item_id = item
          shaving_item.save
          @item.increment!(:uses)
        end
        format.html { redirect_to @shaving_record, notice: 'Shaving record was successfully created.' }
        format.json { render :show, status: :created, location: @shaving_record }
      else
        format.html { render :new }
        format.json { render json: @shaving_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shaving_records/1
  # PATCH/PUT /shaving_records/1.json
  def update

    @shaving_items = params['shave_record'][:item_ids]
    @shaving_items_in_record = ShavingItem.where(shaving_record_id: params[:id]).pluck(:item_id)
    @shaving_items_in_record = @shaving_items_in_record.map(&:to_s)

    @items_to_add = @shaving_items - @shaving_items_in_record
    @items_to_remove = @shaving_items_in_record - @shaving_items

    respond_to do |format|
      if @shaving_record.update(shaving_record_params)

       @items_to_add.each do |new_item|
         shaving_item = ShavingItem.new
         item = Item.find(new_item)
         shaving_item.shaving_record_id = @shaving_record.id
         shaving_item.item_id = new_item
         shaving_item.save
         item.increment!(:uses)
       end

       @items_to_remove.each do |old_item|
         shaving_item_removed = ShavingItem.find_by_shaving_record_id_and_item_id(params[:id], old_item)
         shaving_item_removed.destroy
         item = Item.find(old_item)
         item.decrement!(:uses)
       end

        format.html { redirect_to @shaving_record, notice: 'Shaving record was successfully updated.' }
        format.json { render :show, status: :ok, location: @shaving_record }
      else
        format.html { render :edit }
        format.json { render json: @shaving_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shaving_records/1
  # DELETE /shaving_records/1.json
  def destroy
    @shaving_record.destroy
    respond_to do |format|

      shaving_item_removed = ShavingItem.find_by_shaving_record_id(params[:id])
      shaving_item_removed.destroy
      format.html { redirect_to shaving_records_url, notice: 'Shaving record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Get items for shave
  def get_items
    @items = Item.where(user_id: current_user.id)
  end

  private
    def sort_column
      params[:sort] || "created_at"
    end

    def sort_direction
      params[:direction] || "asc"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_shaving_record
      @shaving_record = ShavingRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shaving_record_params
      params.require(:shaving_record).permit(:description, :date, :rating, :picture,
                                             items: [:name, :id], :item_ids =>[]).merge(user_id: current_user.id)
    end

end
