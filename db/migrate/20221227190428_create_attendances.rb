class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.string :title, default: '✓'
      t.date :start
      t.date :end, default: DateTime.now
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
