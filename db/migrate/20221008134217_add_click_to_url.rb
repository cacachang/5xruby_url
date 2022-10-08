class AddClickToUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :click, :integer, default: 0
  end
end
