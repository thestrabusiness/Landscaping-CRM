class RecurringServicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_recurring_service, only: [:show, :edit, :update, :destroy]

  # GET /recurring_services
  # GET /recurring_services.json
  def index
    @recurring_services = RecurringService.all
  end

  # GET /recurring_services/1
  # GET /recurring_services/1.json
  def show
  end

  # GET /recurring_services/new
  def new
    @recurring_service = RecurringService.new
  end

  # GET /recurring_services/1/edit
  def edit
  end

  # POST /recurring_services
  # POST /recurring_services.json
  def create
    @recurring_service = RecurringService.new(recurring_service_params)

    respond_to do |format|
      if @recurring_service.save
        format.html { redirect_to @recurring_service, notice: 'Recurring service was successfully created.' }
        format.json { render :show, status: :created, location: @recurring_service }
      else
        format.html { render :new }
        format.json { render json: @recurring_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_services/1
  # PATCH/PUT /recurring_services/1.json
  def update
    respond_to do |format|
      if @recurring_service.update(recurring_service_params)
        format.html { redirect_to @recurring_service, notice: 'Recurring service was successfully updated.' }
        format.json { render :show, status: :ok, location: @recurring_service }
      else
        format.html { render :edit }
        format.json { render json: @recurring_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurring_services/1
  # DELETE /recurring_services/1.json
  def destroy
    @recurring_price = RecurringPrice.where(:name => :name)
    @recurring_service = RecurringService.find(params[:id])
    
    if @recurring_service.destroy
      flash[:notice] = "#{@recurring_service.name} was deleted succesfully."
      redirect_to @recurring_prices
    else
      flash[:error] = "There was an error deleting the service."
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_service
      @recurring_service = RecurringService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_service_params
      params.require(:recurring_service).permit(:name)
    end
end
