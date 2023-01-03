class AttendancesController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :get_customer

  def index
    @title = "Asistencias de #{@customer.name}"
    @events = @customer.attendances
    puts @events.to_json.html_safe
  end

  def show
  end

  def new
    @attendance = @customer.attendances.build
    @title = "Nueva Asistencia para #{@customer.name}"
  end

  def create
    @attendance = @customer.attendances.build({ start: DateTime.now })
    if @attendance.save
      redirect_to customer_attendances_path(@customer), notice: 'La Asistencia se ha creado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def get_customer
    @customer = Customer.find(params[:customer_id])
  end
end
