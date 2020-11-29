module PhotosHelper

  # 画像のツイートボタンを取得します。
  #
  # @param [Photo < ActiveRecord] photo 写真モデル
  # @return [String] ボタンのHTML
  def photo_tweet_button(photo)
    path = my_tweet_app_tweet_path(text: photo.title, url: photo_show_image_url(photo))
    html_options = { id: "tweet-button-#{photo.id}" }
    button_to 'ツイートする', path, html_options
  end

end
