class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.float :amount
      t.datetime :date
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
