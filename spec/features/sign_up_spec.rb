require 'spec_helper'

describe 'sign up' do

  describe 'valid form' do
    it 'creates user with account' do
      visit new_user_path
      fill_in 'Email', with: 'new_user@site.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign Up'
      expect(User.count).to be 1
      expect(Account.count).to be 1
    end
  end

  describe 'invalid form' do
    it 'does not create user or account' do
      visit new_user_path
      fill_in 'Email', with: 'new_user@site.com'
      fill_in 'Password', with: 'password'
      click_button 'Sign Up'
      expect(User.count).to be 0
      expect(Account.count).to be 0
    end
  end

end
