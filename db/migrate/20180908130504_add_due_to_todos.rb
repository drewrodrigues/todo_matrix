class AddDueToTodos < ActiveRecord::Migration[5.2]
  def change
    add_column :todos, :due, :date
  end
end
