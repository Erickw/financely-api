class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.belongs_to :card
      t.decimal :value
      t.datetime :expire_date

      t.timestamps
    end
  end
end
