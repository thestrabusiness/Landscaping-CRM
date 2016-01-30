class Estimates::EstimateItemsController < ApplicationController
  # GET /estimate_items
  # GET /estimate_items.json
  def index
    @estimate_items = EstimateItem.all
  end

  # GET /estimate_items/1
  # GET /estimate_items/1.json
  def show
  end

  # GET /estimate_items/new
  def new
    @estimate = Estimate.find(params[:estimate_id])
    @estimate_item = EstimateItem.new
  end

  # GET /estimate_items/1/edit
  def edit
  end

  # POST /estimate_items
  # POST /estimate_items.json
  def create
    @estimate = Estimate.find(params[:estimate_id])
    @estimate_item = EstimateItem.new(estimate_item_params)
    @estimate_item.estimate = @estimate
    
    @estimate.update_attribute :total, @estimate.total + (@estimate_item.price * @estimate_item.quantity)

    respond_to do |format|
      if @estimate_item.save
        format.html { redirect_to @estimate, notice: 'Estimate item was successfully created.' }
        format.json { render :show, status: :created, location: @estimate }
      else
        format.html { render :new }
        format.json { render json: @estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estimate_items/1
  # PATCH/PUT /estimate_items/1.json
  def update
    respond_to do |format|
      if @estimate_item.update(estimate_item_params)
        format.html { redirect_to @estimate_item, notice: 'Estimate item was successfully updated.' }
        format.json { render :show, status: :ok, location: @estimate_item }
      else
        format.html { render :edit }
        format.json { render json: @estimate_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estimate_items/1
  # DELETE /estimate_items/1.json
  def destroy
    @estimate = Estimate.find(params[:estimate_id])
    @estimate_item = EstimateItem.find(params[:id])
    
    @estimate.update_attribute :total, @estimate.total - (@estimate_item.price * @estimate_item.quantity)
    
    if @estimate_item.destroy
      flash[:notice] = "#{@estimate_item.name} was deleted succesfully."
      redirect_to @estimate
    else
      flash[:error] = "There was an error deleting the item."
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estimate_item
      @estimate_item = EstimateItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estimate_item_params
      params.require(:estimate_item).permit(:estimate_id, :name, :price, :quantity)
    end
end
