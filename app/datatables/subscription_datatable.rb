class SubscriptionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :edit_subscription_path, :concat, :content_tag, :icon

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Subscription.id" },
      customer: { source: "Subscription.customer_id" },
      plan: { source: "Subscription.plan_id" },
      start_sub: { source: "Subscription.start" },
      end_sub: { source: "Subscription.end" },
      is_active: { source: "Subscription.is_active" },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        customer: record.customer.name,
        plan: record.plan.name,
        is_active: record.is_active,
        start_sub: record.start.strftime('%d/%m/%Y'),
        end_sub: record.end.strftime('%d/%m/%Y'),
        actions: content_tag(:div) do
            link_to(icon("fas", "trash"), record, class: "btn btn-danger btn-sm destroy", data: { action: "destroySubscription#destroy", "destroySubscription-target": "row" })
        end,
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Subscription.all
  end

end

