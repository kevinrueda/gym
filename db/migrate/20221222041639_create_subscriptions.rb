class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.date :start, default: DateTime.current.to_date
      t.date :end
      t.timestamps
    end
  end
end
