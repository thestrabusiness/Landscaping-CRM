class Clients::RecurringPricesController < ApplicationController

  # GET /recurring_prices
  # GET /recurring_prices.json
  def index
    @recurring_prices = RecurringPrice.all
  end

  # GET /recurring_prices/1
  # GET /recurring_prices/1.json
  def show
  end

  # GET /recurring_prices/new
  def new
    @client = Client.find(params[:client_id])
    @recurring_price = RecurringPrice.new
    @recurring_services = RecurringService.all
  end

  # GET /recurring_prices/1/edit
  def edit
  end

  # POST /recurring_prices
  # POST /recurring_prices.json
  def create
    @client = Client.find(params[:client_id])
    @recurring_price = RecurringPrice.new(recurring_price_params)
    @recurring_price.client_id = @client.id
    #@recurring_service = RecurringService.find(@recurring_price.recurring_service_id)
    #@recurring_price.name = @recurring_service.name

    respond_to do |format|
      if @recurring_price.save
        format.html { redirect_to @client, notice: 'Recurring price was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_prices/1
  # PATCH/PUT /recurring_prices/1.json
  def update
    respond_to do |format|
      if @recurring_price.update(recurring_price_params)
        format.html { redirect_to @recurring_price, notice: 'Recurring price was successfully updated.' }
        format.json { render :show, status: :ok, location: @recurring_price }
      else
        format.html { render :edit }
        format.json { render json: @recurring_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurring_prices/1
  # DELETE /recurring_prices/1.json
  def destroy
    @client = Client.find(params[:client_id])
    @recurring_price = RecurringPrice.find(params[:id])
        
    title = @recurring_price.name
    
    if @recurring_price.destroy
      flash[:notice] = "#{title} was deleted succesfully."
      redirect_to @client
    else
      flash[:error] = "There was an error deleting the service."
      render :show
    end
  end

  def import
    RecurringPrice.import(params[:file])
    redirect_to clients_path, notice: "Client prices added succesfully"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_price
      @recurring_price = RecurringPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_price_params
      params.require(:recurring_price).permit(:price, :clients_id, :recurring_service_id, :name)
    end
end

