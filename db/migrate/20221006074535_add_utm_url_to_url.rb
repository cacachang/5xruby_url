class AddUtmUrlToUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :utm_url, :string
  end
end
