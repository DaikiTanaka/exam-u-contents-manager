class Photo < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :image_path, presence: true

  def image_abs_path
    Rails.root.join(image_path) if image_path
  end

end
