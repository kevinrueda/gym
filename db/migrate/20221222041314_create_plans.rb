class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :price
      t.string :number_days

      t.timestamps
    end
  end
end
