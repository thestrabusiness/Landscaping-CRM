class Invoices::ServicesController < ApplicationController

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @invoice = Invoice.find(params[:invoice_id])
    
    unless @invoice.status == "PENDING"
      respond_to do |format|
        format.html { redirect_to @invoice, notice: "Invoice has already been finalized! You can't add more items!" }
        format.json { head :no_content }
      end
    else    
      @service = Service.new
      @client = @invoice.client.id
    
      @recurring_prices = RecurringPrice.where(:client_id => @client)
    end
    
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create    
    @invoice = Invoice.find(params[:invoice_id])
    @service = Service.new(service_params)
    @service.invoice = @invoice
    
    @client = @invoice.client.id
    @service.client_id = @client
  
    unless params[:other_service_name].empty? 
      @service.name = params[:other_service_name]
    end
    
    unless params[:new_price].empty?
      @service.price = params[:new_price]
      @invoice.update_attribute :total,  @invoice.total + (@service.price * @service.quantity) 
    else
      @recurring_price = RecurringPrice.find_by name: @service.name, client_id: @service.client_id 
      @service.price = @recurring_price.price
      @invoice.update_attribute :total,  @invoice.total + (@service.price * @service.quantity) 
    end
      
      
    
    respond_to do |format|
      if @service.save
        format.html { redirect_to @invoice, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @invoice = Invoice.find(params[:invoice_id])
    @service = Service.find(params[:id])
    title = @service.name
    
    @invoice.update_attribute :total,  @invoice.total - (@service.price * @service.quantity)
    
    if @service.destroy
      flash[:notice] = "#{title} was deleted succesfully."
      redirect_to @invoice
    else
      flash[:error] = "There was an error deleting the service."
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :category, :quantity, :invoice_id, :price, :client_id, :other_service_name, :new_price)
    end
end
