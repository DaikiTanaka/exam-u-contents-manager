require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test 'image_path を元に image_abs_path が生成される' do
    photo = Photo.new(image_path: 'test.jpg')
    assert_equal Rails.root.join('test.jpg'), photo.image_abs_path
  end

  test '[正常系]バリデーション タイトル 30文字' do
    photo = Photo.new(title: 'a' * 30)
    photo.valid?
    assert photo.errors[:title].blank?
  end

  test '[異常系]バリデーション タイトル 空' do
    photo = Photo.new
    photo.valid?
    assert photo.errors[:title].present?
  end

  test '[異常系]バリデーション タイトル 31文字' do
    photo = Photo.new(title: 'a' * 31)
    photo.valid?
    assert photo.errors[:title].present?
  end

  test '[正常系]バリデーション 写真' do
    photo = Photo.new(image_path: 'test.jpg')
    photo.valid?
    assert photo.errors[:image_path].blank?
  end

  test '[異常系]バリデーション 写真 空' do
    photo = Photo.new
    photo.valid?
    assert photo.errors[:image_path].present?
  end

  test '[異常系]バリデーション ユーザID 空' do
    photo = Photo.new
    assert photo.errors[:user_id].present?
  end

  test '[正常系]バリデーション 全ての属性が valid な場合' do
    user = User.create(username: 'user1', password: 'password')
    photo = user.photos.new(title: 'test', image_path: 'test.jpg')
    assert photo.valid?
  end

end
