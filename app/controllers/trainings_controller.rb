class TrainingsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :get_customer
  before_action :set_training, only: [:show, :edit, :update, :destroy]

  def index
    @title = "Rutinas de #{@customer.name}"
    respond_to do |format|
      format.html
      format.json { render json: TrainingDatatable.new(params, view_context: view_context, customer: params[:customer_id]) }
    end
  end

  def show
  end

  def new
    @training = @customer.trainings.build
    @title = "Nueva Rutina para #{@customer.name}"
  end

  def create
    @training = @customer.trainings.build(training_params)
    if @training.save
      redirect_to customer_trainings_path(@customer), notice: 'La Rutina se ha creado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @training.update(training_params)
      redirect_to customer_trainings_path(@customer), notice: 'La Rutina se ha actualizado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @training.destroy
  end

  private

  def get_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_training
    @training = Training.find((params[:id]))
  end

  def training_params
    params.require(:training).permit(:number, :start, :customer)
  end
end
