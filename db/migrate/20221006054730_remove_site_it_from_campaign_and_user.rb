# frozen_string_literal: true

class RemoveSiteItFromCampaignAndUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :campaigns, :site_id, :string
    remove_column :users, :site_id, :string
  end
end
