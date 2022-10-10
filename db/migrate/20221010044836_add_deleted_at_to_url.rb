class AddDeletedAtToUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :deleted_at, :datetime
    add_index :urls, :deleted_at
  end
end
