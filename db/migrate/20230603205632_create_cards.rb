class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.belongs_to :user
      t.string :number
      t.string :name
      t.string :limit
      t.string :logo_url

      t.timestamps
    end
  end
end
