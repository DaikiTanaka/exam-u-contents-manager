module PhotosHelper

  # 画像のツイートボタンを取得します。
  #
  # @param [Photo < ActiveRecord] photo 写真モデル
  # @return [String] ボタンのHTML
  def photo_tweet_button(photo)
    button_to 'ツイートする',
              my_tweet_app_tweet_path(text: photo.title, url: photo_show_image_url(photo)),
              { id: "tweet-button-#{photo.id}" }
  end

end
