class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])
    @services = @invoice.services
    @recurring_prices = RecurringPrice.where(:client_id => @invoice.client.id)
    
#     respond_to do |format|
#      format.html { render :show }
#      format.pdf  do
#        path = invoice_url(@invoice)
#        filename = "invoice_#{@invoice.id}"
#        
#        pdf = PDFKit.new(path)
#        pdf.to_pdf
#        
#      end
#    end
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new    
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.status = "PENDING"
    @invoice.total = 0

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def set_sent
    @invoice = Invoice.find(params[:id])
    
    if @invoice.status == "SENT"
      respond_to do |format|
        format.html { redirect_to @invoice, notice: 'Invoice has already been #{@invoice.status}!' }
        format.json { head :no_content }
      end
    elsif @invoice.status == "PAID"
        respond_to do |format|
          format.html { redirect_to @invoice, notice: 'Invoice has already been PAID!' }
          format.json { head :no_content }
        end
    else    
      @invoice.update_attribute :status, "SENT"

      @client = @invoice.client
      @client.update_attribute :balance, @client.balance + @invoice.total

      flash[:notice] = "Invoice marked as SENT, client balance updated!"

      redirect_to @invoice
    end
  end
  
  def set_paid
    @invoice = Invoice.find(params[:id])
    
    if @invoice.status == "PAID"
        respond_to do |format|
          format.html { redirect_to @invoice, notice: 'Invoice has already been PAID!' }
          format.json { head :no_content }
        end
    else    
      @invoice.update_attribute :status, "PAID"
    
      @client = @invoice.client
      @client.update_attribute :balance, @client.balance - @invoice.total
      
      flash[:notice] = "Invoice marked PAID!"    
      redirect_to @invoice
    end
  end
  
  def show_pdf
    
    @invoice = Invoice.find(params[:id])
    @services = @invoice.services
    @recurring_prices = RecurringPrice.where(:client_id => @invoice.client.id)
    
    #pass view to PDFKIT, render pdf inline    
    path = invoice_url(@invoice)
    filename = "invoice_#{@invoice.id}"
    
    kit = PDFKit.new(path)
    pdf = kit.to_pdf
    send_data(pdf, :filename => filename, :type => 'application/pdf', :disposition => 'inline')
    
  end
  
    
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:date, :performed_by, :status, :note, :client_id)
    end
end
