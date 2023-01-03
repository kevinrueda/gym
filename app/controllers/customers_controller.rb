class CustomersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  def index
    @title = "Clientes"
    respond_to do |format|
      format.html
      format.json { render json: CustomerDatatable.new(params, view_context: view_context) }
    end
  end

  def show
  end

  def new
    @customer = Customer.new
    @title = "Nuevo Cliente"
  end

  def create
    if Customer.create(customer_params)
      redirect_to customers_path, notice: 'El Cliente se ha creado correctamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @title = "Editar Cliente"
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path, notice: 'El Cliente se ha actualizado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :dni, :address, :phone, :birth_date, :email, :occupation, :weight, :objectives, :is_operated, :spine_problems, :others)
  end
end
