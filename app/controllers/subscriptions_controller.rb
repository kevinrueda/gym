class SubscriptionsController < ApplicationController
  layout "admin", :except => :print_invoice
  before_action :authenticate_user!
  before_action :set_subscription, only: [:show, :edit, :update, :destroy, :send_invoice_email, :print_invoice]

  def index
    @title = "Suscripciones"
    @day_total = Subscription.day_total
    @month_total = Subscription.month_total
    respond_to do |format|
      format.html
      format.json { render json: SubscriptionDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    @iframe = print_invoice_path(@subscription)
  end

  def new
    @subscription = Subscription.new
    @title = "Nueva Suscripción"
  end

  def create
    @customer = Customer.find(params[:subscription][:customer_id])
    if @customer.subscription_status
      start_sub = @customer.subscriptions.last.end + 1.days
    else
      start_sub = DateTime.current.to_date
    end
    @subscription = Subscription.create(subscription_params)
    @subscription.start = start_sub
    @subscription.end = params[:subscription][:end]
    if @subscription.save
      SubscriptionMailer.with(subscription: @subscription).invoice.deliver_later
      redirect_to subscriptions_path, notice: 'La Suscripción se ha creado correctamente'
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
    @title = "Editar Suscripción"
  end

  def update
    if @subscription.update(subscription_params)
      redirect_to subscriptions_path, notice: 'La Suscripción se ha actualizado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @subscription.destroy
  end

  def send_invoice_email
    SubscriptionMailer.with(subscription: @subscription).invoice.deliver_later
  end

  def print_invoice
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:customer_id, :plan_id, :end)
  end
end
