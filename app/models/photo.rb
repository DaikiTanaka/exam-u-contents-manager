class Photo < ApplicationRecord

  belongs_to :user

  scope :recently_created, -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 30 }
  validates :image_path, presence: true

  # 画像ファイルの物理・絶対パスを取得します。
  #
  # @return [String or nil] 画像ファイルの物理・絶対パス, image_path が空の場合は nil
  def image_abs_path
    Rails.root.join(image_path) if image_path
  end

  class << self

    # アップロードされた写真を保存します。
    #
    # * 物理的に画像ファイルを保存します
    # * DBへ写真モデルを登録します
    #
    # @param [User < ActiveRecord] user 写真の所有者となるユーザーのユーザーモデル
    # @param [String] photo_title 写真のタイトル
    # @param [ActionDispatch::Http::UploadedFile] uploaded_file フォームからアップロードされた画像ファイル
    # @param [->(){}] when_succeeded 保存成功時のコールバック
    # @param [->(ActiveModel::Errors){}] when_failed 保存失敗時のコールバック, 第１引数にはバリデーションエラーの内容が渡されます
    # @return [不使用]
    def create_by_uploaded_file(
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

    # 指定した画像ファイルの保存先の物理・相対パスを取得します。
    #
    # @param [ActionDispatch::Http::UploadedFile] uploaded_file フォームからアップロードされた画像ファイル
    # @return [String] 画像ファイルの保存先の物理・相対パス
    def make_image_file_storage_path(uploaded_file)
      "data/#{SecureRandom.uuid}#{File.extname(uploaded_file.original_filename)}"
    end

  end

end
