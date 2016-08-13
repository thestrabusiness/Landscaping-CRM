class Clients::ClientPricesController < ApplicationController

  def index
    @client_prices = ClientPrice.all
  end

  def show
  end

  def new
    @client = Client.find(params[:client_id])
    @client_price = ClientPrice.new
    @services = Service.all
  end

  def edit
  end


  def create
    @client = Client.find(params[:client_id])
    @client_price = ClientPrice.new(client_price_params)
    @client_price.client_id = @client.id

    respond_to do |format|
      if @client_price.save
        format.html { redirect_to @client, notice: 'Service was successfully added to client.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client_price.update(client_price_params)
        format.html { redirect_to @client_price, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_price }
      else
        format.html { render :edit }
        format.json { render json: @client_price.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client = Client.find(params[:client_id])
    @client_price = ClientPrice.find(params[:id])
        
    title = @client_price.name
    
    if @client_price.destroy
      flash[:notice] = "#{title} was deleted succesfully."
      redirect_to @client
    else
      flash[:error] = "There was an error deleting the service."
      render :show
    end
  end

  def import
    ClientPrice.import(params[:file])
    redirect_to clients_path, notice: "Client prices added succesfully"
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_price
      @client_price = ClientPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_price_params
      params.require(:client_price).permit(:price, :clients_id, :service_id, :name)
    end
end

