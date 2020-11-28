require 'application_system_test_case'

class PhotosIndexTest < ApplicationSystemTestCase

  test '[正常系]写真一覧が表示される' do
    user = create_user
    user.photos.create(title: 'テスト1', image_path: 'test/fixtures/files/logo.png')
    user.photos.create(title: 'テスト2', image_path: 'test/fixtures/files/logo.png')
    user.photos.create(title: 'テスト3', image_path: 'test/fixtures/files/logo.png')
    login
    visit photos_path
    assert_text '写真一覧'
    user.photos.each do |photo|
      assert_text photo.title
      assert_selector("#photo-list-item-#{photo.id}")
      assert_selector("#photo-list-item-#{photo.id} .photo-title")
      assert_selector("#photo-list-item-#{photo.id} .photo-image")
    end
  end

  test '[正常系]写真が1件もない場合でもエラーにならない' do
    create_user
    login
    visit photos_path
    assert_text '写真一覧'
    assert_selector('.photo-list-item', count: 0)
  end

  test '[正常系]他のユーザの写真は表示されない' do
    user = create_user
    user.photos.create(title: 'テスト1', image_path: 'test/fixtures/files/logo.png')
    user.photos.create(title: 'テスト2', image_path: 'test/fixtures/files/logo.png')
    user.photos.create(title: 'テスト3', image_path: 'test/fixtures/files/logo.png')
    create_user(username: 'user2', password: 'password2')
    login(username: 'user2', password: 'password2')
    visit photos_path
    assert_text '写真一覧'
    assert_selector('.photo-list-item', count: 0)
  end

  test '[異常系]未ログイン状態で写真一覧にアクセスすると、ログイン画面へ遷移する' do
    visit photos_path
    assert_current_path '/sessions/new'
  end

  test '[正常系]写真アップロード画面へのリンクを押下すると、写真アップロード画面へ遷移する' do
    create_user
    login
    visit photos_path
    click_link 'link-to-upload'
    assert_current_path '/photos/new'
  end

end

class PhotosCreateTest < ApplicationSystemTestCase

  test '[正常系]写真のアップロードに成功すると、写真一覧へ遷移する' do
    create_user
    login
    visit new_photo_path
    assert_text '写真アップロード'
    fill_in 'forms_photo_title', with: 'test'
    attach_file 'test/fixtures/files/logo.png'
    click_on 'commit'
    assert_current_path '/'
    assert_text '写真一覧'
  end

  test '[正常系]タイトルが入力されていないと写真のアップロードに失敗し、エラーメッセージが表示される' do
    create_user
    login
    visit new_photo_path
    attach_file 'test/fixtures/files/logo.png'
    click_on 'commit'
    assert_text 'タイトルを入力してください'
    assert_current_path '/photos'
    assert_text '写真アップロード'
  end

  test '[正常系]タイトルが30文字を超えていると写真のアップロードに失敗し、エラーメッセージが表示される' do
    create_user
    login
    visit new_photo_path
    fill_in 'forms_photo_title', with: 'a' * 31
    attach_file 'test/fixtures/files/logo.png'
    click_on 'commit'
    assert_text 'タイトルは30文字以内で入力してください'
    assert_current_path '/photos'
    assert_text '写真アップロード'
  end

  test '[正常系]写真が選択されていないと写真のアップロードに失敗し、エラーメッセージが表示される' do
    create_user
    login
    visit new_photo_path
    fill_in 'forms_photo_title', with: 'test'
    click_on 'commit'
    assert_text '写真を入力してください'
    assert_current_path '/photos'
    assert_text '写真アップロード'
  end

  test '[正常系]キャンセルリンクを押下すると、写真一覧画面へ遷移する' do
    create_user
    login
    visit new_photo_path
    click_link 'link-to-index'
    assert_current_path '/photos'
    assert_text '写真一覧'
  end

end