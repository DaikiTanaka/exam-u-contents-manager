require 'test_helper'

class PhotoHelperPhotoTweetButtonTest < ActiveSupport::TestCase

  class TestHelper < ActionView::Base
    include PhotosHelper
    include Rails.application.routes.url_helpers
    Rails.application.routes.default_url_options[:host] = Capybara.server_host
  end

  test '[正常系]ツイートボタンを取得できる' do
    helper = TestHelper.new
    photo = Photo.new(id: 1, user_id: 1, title: 'テスト1', image_path: 'test/fixtures/files/logo.png')
    button_html = helper.photo_tweet_button(photo)
    assert button_html.include? 'ツイートする'
  end

end
