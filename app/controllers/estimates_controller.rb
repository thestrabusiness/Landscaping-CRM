class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]

  # GET /estimates
  # GET /estimates.json
  def index
    @estimates = Estimate.all
  end

  # GET /estimates/1
  # GET /estimates/1.json
  def show
    @estimate = Estimate.find(params[:id])
    @estimate_items = @estimate.estimate_items
  end

  # GET /estimates/new
  def new
    @estimate = Estimate.new
  end

  # GET /estimates/1/edit
  def edit
  end

  # POST /estimates
  # POST /estimates.json
  def create
    @estimate = Estimate.new(estimate_params)

    respond_to do |format|
      if @estimate.save
        format.html { redirect_to @estimate, notice: 'Estimate was successfully created.' }
        format.json { render :show, status: :created, location: @estimate }
      else
        format.html { render :new }
        format.json { render json: @estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /estimates/1
  # PATCH/PUT /estimates/1.json
  def update
    respond_to do |format|
      if @estimate.update(estimate_params)
        format.html { redirect_to @estimate, notice: 'Estimate was successfully updated.' }
        format.json { render :show, status: :ok, location: @estimate }
      else
        format.html { render :edit }
        format.json { render json: @estimate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /estimates/1
  # DELETE /estimates/1.json
  def destroy
    @estimate.destroy
    respond_to do |format|
      format.html { redirect_to estimates_url, notice: 'Estimate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def estimate_pdf
    @estimate = Estimate.find(params[:id])
    @estimate_items = @estimate.estimate_items
    
    render :layout => 'pdf_layout'
  end
  
  def view_estimate_pdf
    @estimate = Estimate.find(params[:id])
    path = estimate_pdf_estimate_url(@estimate)
    filename = "estimate_#{@estimate.id}"
    
    kit = PDFKit.new(path)
    pdf = kit.to_pdf
    send_data(pdf, :filename => filename, :type => 'application/pdf', :disposition => 'inline')
  end
  
  def generate_estimate_pdfs
    #generate pdfs from selected invoices and save each to file
    @estimates = Estimate.find(params[:selected_estimates])
    files = []
    @estimates.each do |estimate|
      path = estimate_pdf_estimate_url(estimate)
      filename = "estimate_#{estimate.id}.pdf"
      files.push filename    
      
      kit = PDFKit.new(path)
      pdf = kit.to_file("#{Rails.root}/public/estimates/#{filename}")
    end
    
    #Combine generated PDFs into single file
    pdf_pack = CombinePDF.new
    files.each do |file|
      pdf_pack << CombinePDF.load("#{Rails.root}/public/estimates/#{file}")
    end
    pack_filename = "estimates#{Date.today.to_formatted_s(:iso8601)}.pdf"
    pdf_pack.save "#{Rails.root}/public/estimates/#{pack_filename}"
    
    send_file("#{Rails.root}/public/estimates/#{pack_filename}", :type => 'application/pdf', :disposition => 'inline')
  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estimate
      @estimate = Estimate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estimate_params
      params.require(:estimate).permit(:date, :total, :notes, :client_id)
    end
end
