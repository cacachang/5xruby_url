# frozen_string_literal: true

class AddUrlIdToCampaign < ActiveRecord::Migration[7.0]
  def change
    add_reference :campaigns, :url
  end
end
