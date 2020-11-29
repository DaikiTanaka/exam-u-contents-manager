class Photo < ApplicationRecord

  belongs_to :user

  scope :recently_created, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 30 }
  validates :image_path, presence: true

  def image_abs_path
    Rails.root.join(image_path) if image_path
  end

  def self.create_by_uploaded_file(
    user:,
    photo_title:,
    uploaded_file:,
    when_succeeded: -> {},
    when_failed: -> (errors) { }
  )
    image_path = uploaded_file ? make_image_file_storage_path(uploaded_file) : nil
    photo = user.photos.build(title: photo_title, image_path: image_path)
    if photo.save
      File.binwrite(photo.image_abs_path, uploaded_file.read)
      when_succeeded.call and return
    else
      when_failed.call photo.errors
    end
  end

  private

  def self.make_image_file_storage_path(uploaded_file)
    "data/#{SecureRandom.uuid}#{File.extname(uploaded_file.original_filename)}"
  end

end
