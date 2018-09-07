class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :details
      t.integer :priority

      t.timestamps
    end
  end
end
