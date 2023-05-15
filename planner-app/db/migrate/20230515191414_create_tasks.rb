class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.boolean :completed, null: false, default: false
      t.datetime :due_at
      t.references :task_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
