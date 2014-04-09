require 'spec_helper'

describe 'sign up' do

  describe 'valid form' do
    it 'creates new user' do
      expect {
        visit new_user_path
        fill_in 'Email', with: 'new_user@site.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign Up'
      }.to change(User, :count).by 1
    end
  end

  describe 'invalid form' do
    it 'does not create new user' do
      expect {
        visit new_user_path
        fill_in 'Email', with: 'new_user@site.com'
        fill_in 'Password', with: 'password'
        click_button 'Sign Up'
      }.to change(User, :count).by 0
    end
  end

end
