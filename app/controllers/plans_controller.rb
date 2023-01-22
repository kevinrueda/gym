class PlansController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  def index
    @title = "Planes"
    respond_to do |format|
      format.html
      format.json { render json: PlanDatatable.new(params, view_context: view_context) }
    end
  end

  def show
  end

  def new
    @plan = Plan.new
    @title = "Nuevo Plan"
  end

  def create
    if Plan.create(plan_params)
      redirect_to plans_path, notice: 'El Plan se ha creado correctamente'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @title = "Editar Plan"
  end

  def update
    if @plan.update(plan_params)
      redirect_to plans_path, notice: 'El Plan se ha actualizado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plan.destroy
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :price)
  end
end
