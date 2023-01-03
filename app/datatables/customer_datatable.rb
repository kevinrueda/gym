class CustomerDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :link_to_if, :subscription_path, :edit_customer_path, :customer_trainings_path, :customer_attendances_path, :concat, :content_tag, :icon

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Customer.id" },
      name: { source: "Customer.name" },
      dni: { source: "Customer.dni" },
      created_at: { source: "Customer.created_at" }
    }
  end

  def data
    actions = nil
    records.map do |record|
      {
        id: record.id,
        status: record.subscription_status,
        name: record.name,
        dni: record.dni,
        created_at: record.created_at.strftime('%d/%m/%Y'),
        actions: content_tag(:div) do
          actions = link_to(icon("fas", "clipboard-user"), customer_attendances_path(record.id), class: "btn btn-secondary btn-sm mr-1") +
            link_to(icon("fas", "dumbbell"), customer_trainings_path(record.id), class: "btn btn-info btn-sm mr-1")
            if record.subscriptions.exists?
              actions += link_to(icon("fas", "receipt"), subscription_path(record.subscriptions.last), class: "btn btn-primary btn-sm mr-1")
            end
          actions += link_to(icon("fas", "edit"), edit_customer_path(record), class: "btn btn-warning btn-sm mr-1") +
            link_to(icon("fas", "trash"), record, class: "btn btn-danger btn-sm destroy", data: { action: "destroyCustomer#destroy", "destroyCustomer-target": "row" })
        end,
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Customer.all
  end

end
