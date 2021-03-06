class InvoicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show_pdf, :generate_pdf, :generate_multiple_pdfs, :labels]
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /invoices
  # GET /invoices.json
  def index
    @search = InvoiceSearch.new(params[:search])
    @invoices = @search.scope.order(sort_column + " " + sort_direction)
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
    @client_prices = ClientPrice.where(:client_id => @invoice.client.id)
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
    if @invoice.status == "SENT" || @invoice.status == "PAID"
      respond_to do |format|
        format.html { redirect_to @invoice, notice: "Invoice has already been #{@invoice.status}!" }
        format.json { head :no_content }
      end
    else
      @invoice.destroy
      respond_to do |format|
        format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end
  
  def set_sent
    @invoice = Invoice.find(params[:id])
    
    if @invoice.status == "SENT"
      respond_to do |format|
        format.html { redirect_to @invoice, notice: "Invoice has already been #{@invoice.status}!" }
        format.json { head :no_content }
      end
    elsif @invoice.status == "PAID"
        respond_to do |format|
          format.html { redirect_to @invoice, notice: 'Invoice has already been PAID!' }
          format.json { head :no_content }
        end
    else    
      @invoice.update_attribute :status, "SENT"
      flash[:notice] = "Invoice marked as '#{@invoice.status}'!"
      redirect_to @invoice
    end
  end
  
  def set_multiple_sent(invoices)
    invoices.each do |invoice|
      unless invoice.status == "SENT" || invoice.status == "PAID"
        invoice.update_attribute :status, "SENT"
      end
    end
    
    redirect_to invoices_url
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
      flash[:notice] = "Invoice marked '#{@invoice.status}'!"    
      redirect_to @invoice
    end
  end
  
  def set_multiple_paid(invoices)
    invoices.each do |invoice|
      unless invoice.status == "PAID"
        invoice.update_attribute :status, "PAID"
      end
    end
    
    redirect_to invoices_url
  end
  
  def show_pdf
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
    
    render :layout => 'pdf_layout'
  end
  
  def generate_pdf
    @invoice = Invoice.find(params[:id])
    @invoice.build_pdf
#    path = show_pdf_invoice_url(@invoice)
#    filename = "invoice_#{@invoice.id}"
#    
#    kit = PDFKit.new(path)
#    pdf = kit.to_pdf
#    send_data(pdf, :filename => filename, :type => 'application/pdf', :disposition => 'inline')
  end
  
  def generate_multiple_pdfs
    @invoices = Invoice.find(params[:selected_invoices])
    
    if params[:commit] == "Print Labels"      
      render :labels, :layout => 'labels_layout'
    elsif params[:commit] == "Set Sent" || params[:commit] == "Set Paid"
        if params[:commit] == "Set Sent"
          set_multiple_sent(@invoices)
        else
          set_multiple_paid(@invoices)
        end
    else
      
      #generate pdfs from selected invoices and save each to file
      files = []
      @invoices.each do |invoice|
        path = show_pdf_invoice_url(invoice)
        filename = "invoice_#{invoice.id}.pdf"
        files.push filename    

        kit = PDFKit.new(path)
        pdf = kit.to_file("#{Rails.root}/public/invoices/#{filename}")
      end
    


      #Combine generated PDFs into single file
      pdf_pack = CombinePDF.new
      files.each do |file|
        pdf_pack << CombinePDF.load("#{Rails.root}/public/invoices/#{file}")
      end
      pack_filename = "invoices_#{Date.today.to_formatted_s(:iso8601)}.pdf"
      pdf_pack.save "#{Rails.root}/public/invoices/#{pack_filename}"

      send_file("#{Rails.root}/public/invoices/#{pack_filename}", :type => 'application/pdf')
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def sort_column
      params[:sort] || "date"
    end

    def sort_direction
      params[:direction] || "desc"
    end


    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:date, :performed_by, :status, :note, :client_id, :client_lastname, :ids, :selected_invoices)
    end
end
