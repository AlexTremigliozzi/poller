class CreateSlas < ActiveRecord::Migration
  def change
    create_table :slas do |t|
      t.string :sla1
      t.string :sla2
      t.integer :diffnum

      t.timestamps null: false
    end
  end
end
