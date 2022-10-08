class CreateClickLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :click_logs do |t|
      t.references :url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
