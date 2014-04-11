require 'spec_helper'
require 'support/authenticate'

describe "ToDos" do
  include Authenticate

  let(:account) { FactoryGirl.create :account }
  let(:user) { FactoryGirl.create :user,
    account: account }

  before do
    log_in
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
