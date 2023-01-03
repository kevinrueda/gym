class TrainingDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :edit_customer_training_path,:customer_training_path, :concat, :content_tag, :icon

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      number: { source: "Training.number" },
      start: { source: "Training.start" },
    }
  end

  def data
    records.map do |record|
      {
        number: record.number,
        start: record.start.strftime('%d/%m/%Y'),
        actions: content_tag(:div) do
          link_to(icon("fas", "edit"), edit_customer_training_path(record.customer, record), class: "btn btn-warning btn-sm mr-1") +
          link_to(icon("fas", "trash"), customer_training_path(Customer.find(options[:customer]), record), class: "btn btn-danger btn-sm destroy", data: { action: "destroyTraining#destroy", "destroyTraining-target": "row" })
        end,
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Customer.find(options[:customer]).trainings
  end

end
