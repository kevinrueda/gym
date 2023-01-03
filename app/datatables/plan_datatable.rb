class PlanDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :link_to, :edit_plan_path, :concat, :content_tag, :icon

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      name: { source: "Plan.name" },
      description: { source: "Plan.price" },
      created_at: { source: "Plan.number_days" }
    }
  end

  def data
    records.map do |record|
      {
        name: record.name,
        price: record.price,
        number_days: record.number_days,
        actions: content_tag(:div) do
            link_to(icon("fas", "edit"), edit_plan_path(record), class: "btn btn-warning btn-sm mr-1")
        end,
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Plan.all
  end

end
