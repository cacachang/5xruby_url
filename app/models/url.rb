class Url < ApplicationRecord

  # association
  belongs_to :user
  has_one :campaign
  has_many :click_logs, dependent: :destroy
  has_one :tag

  # validation
  validates :page, presence: :true

  after_create :encode_id

  default_scope { where(deleted_at: nil) }

  private

  def encode_id
    update(shortener: "#{SecureRandom.hex(4)}")
  end
end
