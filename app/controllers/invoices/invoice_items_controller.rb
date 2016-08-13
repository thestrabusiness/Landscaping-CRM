class Invoices::InvoiceItemsController < ApplicationController

  def index
    @invoice_items = InvoiceItem.all
  end

  def show
  end

  def new
    @invoice = Invoice.find(params[:invoice_id])
    
    unless @invoice.status == "PENDING"
      respond_to do |format|
        format.html { redirect_to @invoice, notice: "Invoice has already been finalized! You can't add more items!" }
        format.json { head :no_content }
      end
    else    
      @invoice_item = InvoiceItem.new
      @client = @invoice.client.id
    
      @client_prices = ClientPrice.where(:client_id => @client)
    end
    
  end

  def edit
  end

  def create    
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = InvoiceItem.new(invoice_item_params)
    @invoice_item.invoice = @invoice
    
    @client = Client.find(@invoice.client.id)
    @invoice_item.client_id = @client.id
  
    unless params[:other_service_name].empty? 
      @invoice_item.name = params[:other_service_name]
    end
    
    unless params[:new_price].empty?
      @invoice_item.price = params[:new_price]
      @invoice.update_attribute :total,  @invoice.total + (@invoice_item.price * @invoice_item.quantity)
      @client.update_attribute :balance, (@client.balance + (@invoice_item.price * @invoice_item.quantity))
    else
      @client_price = ClientPrice.find_by name: @invoice_item.name, client_id: @invoice_item.client_id 
      @invoice_item.price = @client_price.price
      @invoice.update_attribute :total,  @invoice.total + (@invoice_item.price * @invoice_item.quantity)
      @client.update_attribute :balance, (@client.balance + (@invoice_item.price * @invoice_item.quantity))
      
    end
      
      
    
    respond_to do |format|
      if @invoice_item.save
        format.html { redirect_to @invoice, notice: 'Invoice item was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice_item.update(invoice_item_params)
        format.html { redirect_to @invoice_item, notice: 'Invoice item was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice_item }
      else
        format.html { render :edit }
        format.json { render json: @invoice_item.errors, status: :unprocessable_entity }
      end
    end
  end

def destroy
    @invoice = Invoice.find(params[:invoice_id])
    
  if @invoice.status == "PENDING"
    @invoice_item = InvoiceItem.find(params[:id])
    @client = Client.find(@invoice.client.id)
    title = @invoice_item.name
    
    @invoice.update_attribute :total,  @invoice.total - (@invoice_item.price * @invoice_item.quantity)
    @client.update_attribute :balance, (@client.balance - (@invoice_item.price * @invoice_item.quantity))
    
    if @invoice_item.destroy
      flash[:notice] = "#{title} was deleted succesfully."
      redirect_to @invoice
    else
      flash[:error] = "There was an error deleting the item from the invoice."
      render :show
    end
  else
    respond_to do |format|
      format.html { redirect_to @invoice, notice: "You can no longer modify this invoice!" }
      format.json { head :no_content }
    end
  end
    
end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_item
      @invoice_item = InvoiceItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_item_params
      params.require(:invoice_item).permit(:name, :category, :quantity, :invoice_id, :price, :client_id, :other_service_name, :new_price)
    end
end
