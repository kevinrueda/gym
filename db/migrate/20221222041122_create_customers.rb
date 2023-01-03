class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :dni
      t.string :name
      t.string :address
      t.string :phone
      t.date :birth_date
      t.string :email
      t.string :occupation
      t.string :weight
      t.string :objectives
      t.boolean :is_operated
      t.boolean :spine_problems
      t.string :others

      t.timestamps
    end
  end
end
