class ClientsController < ApplicationController
  before_filter :authenticate_user!, except: [:reminder, :generate_reminders]
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /clients
  # GET /clients.json
  def index
    @search = Client.search do
      fulltext params[:search]
      order_by(:id, :asc)
      paginate(:page => params[:page] || 1, :per_page => 30)
    end
    @clients = @search.results
      
    
#    @clients = Client.all
#    if params[:search]
#      @clients = Client.search(params[:search]).order(sort_column + " " + sort_direction)
#    else
#      @clients.order(sort_column + " " + sort_direction)
#    end
    
  respond_to do |format|
      format.html
      format.csv do
        @clients = Client.all
        render text: @clients.to_csv
      end        
    end
  end

  def show
    @client = Client.find(params[:id])
    @client_prices = @client.client_prices
    @services = Service.all
    @invoices = Invoice.where(:client_id => params[:id]).limit(5).order(date: :desc)
    @payments = Payment.where(:client_id => params[:id]).limit(5).order(date: :desc)
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    @client.balance = 0
        
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def import
    Client.import(params[:file])
    redirect_to clients_path, notice: "Clients added succesfully!"
  end

  def summary
    @clients = Client.all.order(id: :asc)
    
    render :layout => 'pdf_layout'
  end

  def reminder
    @client = Client.find(params[:id])
    @date = Date.today.strftime('%m/%d/%Y')

    render layout: 'pdf_layout'
  end

  def generate_reminders
    @clients = Client.where('CAST(balance AS numeric) > ?', 0.0)

    reminders = []
    @clients.each do |client|
      path = reminder_client_url(client)
      filename = "#{client.last_name}_reminder_#{Time.current.strftime('%Y%m%d')}.pdf"
      reminders << filename

      kit = PDFKit.new(path)
      pdf = kit.to_file("#{Rails.root}/reminders/#{filename}")
    end

    pdf_pack = CombinePDF.new
    reminders.each do |reminder|
      pdf_pack << CombinePDF.load("#{Rails.root}/reminders/#{reminder}")
    end
    pack_filename = "reminders_#{Date.today.to_formatted_s(:iso8601)}.pdf"
    pdf_pack.save "#{Rails.root}/reminders/#{pack_filename}"

    send_file("#{Rails.root}/reminders/#{pack_filename}", :type => 'application/pdf')
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def sort_column
      params[:sort] || "id"
    end

    def sort_direction
      params[:direction] || "asc"
    end    

    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:first_name, :last_name, :billing_address, :job_address, :city, :state, :zip)
    end
end
