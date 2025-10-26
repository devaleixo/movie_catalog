class CreateImportStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :import_statuses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :filename
      t.string :status
      t.integer :total_rows
      t.integer :processed_rows
      t.integer :success_count
      t.integer :error_count
      t.text :error_messages
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
