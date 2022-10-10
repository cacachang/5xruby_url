# frozen_string_literal: true

class ClickLog < ApplicationRecord
  belongs_to :url, counter_cache: true
end
