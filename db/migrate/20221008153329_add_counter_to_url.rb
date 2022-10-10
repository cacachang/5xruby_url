# frozen_string_literal: true

class AddCounterToUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :urls, :click_logs_count, :integer
  end
end
