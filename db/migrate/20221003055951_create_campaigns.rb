class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :source
      t.string :medium
      t.string :name
      t.string :term
      t.string :content
      t.references :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
