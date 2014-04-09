require 'spec_helper'

describe "ToDos" do
  let(:user) { FactoryGirl.create :user }

  before do
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end

  describe "User adds to-do" do
    it "creates new to-do", js: true do
      expect {
        visit root_path
        click_link 'Add To-do'
        fill_in 'to_do_body', with: 'Create exam'
        click_button 'Add To-do'
        within '#to-do-list-table' do
          page.should have_content 'Create exam'
        end
      }.to change(ToDo, :count).by 1
    end
  end
end
