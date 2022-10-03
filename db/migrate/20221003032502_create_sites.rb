class CreateSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.text :url
      t.string :shortener
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
