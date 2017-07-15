# frozen_string_literal: true
require 'devise'

Devise.setup do |config|
  config.stretches = 1
end

module ControllerMacros
  def login(user, *args)
    before do
      @request.env['devise.mapping'] = Devise.mappings[user.to_sym]
      sign_in FactoryGirl.find_or_create(user.to_sym, *args)
    end
  end

  def sign_in(user = FactoryGirl.create(:user))
    visit new_user_session_path l: I18n.locale
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button I18n.t 'sign_in'
  end

  def login_user
    login(:user)
  end
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.before :suite do
    Warden.test_mode!
  end
  config.after :each do
    Warden.test_reset!
  end
end
