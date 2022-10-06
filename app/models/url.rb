class Url < ApplicationRecord
  # assosciation
  belongs_to :user
  has_one :campaign

  validates :page, presence: :true
  require 'securerandom'

  after_create :encode_id

  private
  def encode_id
    update(shortener: "#{SecureRandom.hex(4)}")
  end
end
