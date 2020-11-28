require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end

def set_server_host
  Capybara.app_host = 'http://localhost:3000'
  Capybara.server_host = 'localhost'
  Capybara.server_port = '3000'
  Capybara.always_include_port = true
end

def create_user(username: 'user1', password: 'password')
  User.create(username: username, password: password)
end

def login(username: 'user1', password: 'password')
  visit new_sessions_path
  fill_in 'forms_session_username', with: username
  fill_in 'forms_session_password', with: password
  click_on 'commit'
end