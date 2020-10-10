class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :body
      t.boolean :is_completed

      t.timestamps
    end
  end
end
