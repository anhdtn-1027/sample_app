class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content image).freeze

  belongs_to :user

  has_one_attached :image

  delegate :name, to: :user

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.maximum}
  validates :image, content_type: {in: Settings.micropost.content.in,
                                   message: I18n.t("microposts.image_format")},
                    size: {less_than: Settings.micropost.image_size,
                           message: I18n.t("microposts.image_size")}

  scope :order_created_at ->{order(created_at: :desc)}
  scope :micropost_feed, ->id {where("user_id = ?", id)}

  def display_image
    image.variant resize_to_limit: Settings.micropost.resize_limit
  end
end
