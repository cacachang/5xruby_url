# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.text :tag
      t.references :url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
