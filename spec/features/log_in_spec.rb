require 'spec_helper'

describe 'log in' do
  let(:user) {
    FactoryGirl.create :user,
    email: 'test@test.com',
    password: 'p',
    password_confirmation: 'p' }

  before do
    user
  end

  describe 'valid user' do
    it 'gives user access to site' do
      visit new_session_path
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'p'
      click_button 'Log In'
      expect(page).to have_selector '#calendar'
    end
  end

  describe 'invalid user' do
    it 'denies user access to site' do
      visit new_session_path
      fill_in 'Email', with: 'e'
      fill_in 'Password', with: 'q'
      click_button 'Log In'
      expect(page).to have_selector '.alert-error'
    end
  end
end
