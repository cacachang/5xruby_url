class Url < ApplicationRecord
  # assosciation
  belongs_to :user
  has_one :campaign

  validates :page, presence: :true
end
