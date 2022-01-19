class Bug < ApplicationRecord
  validates :title, presence: true, length: { minimum: 6 }

  enum bug_type: [:bug, :feature]
  enum bug_status: [:new_bug, :started_bug, :resolved]
  enum feature_status: [:new_feature, :started_feature, :completed_feature]

  has_one_attached :image
  validate :correct_image_mime_type

  private

  def correct_image_mime_type
    if image.attached? && !image.content_type.in?(%w(image/png image/gif))
      errors.add(:image, 'Must be a PNG or a GIF file')
    end
  end

end