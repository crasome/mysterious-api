class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string   :description,  null: false
      t.string   :comment,      null: false,  default: ""
      t.datetime :time,         null: false
      t.decimal  :amount,       null: false,  precision: 8,  scale: 2

      t.references :owner, index: true

      t.timestamps
    end
  end
end
