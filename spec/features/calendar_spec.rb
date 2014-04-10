require 'spec_helper'
require 'support/authenticate'

describe "Calendar" do
  include Authenticate

  let(:user) { FactoryGirl.create :user }

  before do
    log_in
  end

  describe 'view controls' do
    it 'has links for each view' do
      visit root_path
      page.should have_content 'Month'
      page.should have_link 'Week'
    end
  end

  describe 'calendar month view' do
    it 'displays lesson plans for week when clicking Week link' do
      visit root_path
      page.should have_selector('tr', count: 6)
    end
  end

  describe 'calendar week view' do
    it 'displays lesson plans for week when clicking Week link' do
      visit root_path
      click_link 'Week'
      page.should have_selector('th', count: 8)
    end
  end
end
