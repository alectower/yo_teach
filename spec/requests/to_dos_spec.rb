require 'spec_helper'

describe "ToDos" do
  describe "POST /to_dos" do
  	it "creates new to do", js: true do
			expect {
				visit root_path
				click_link 'Add To-do'
				fill_in 'to_do_body', with: 'Create exam'
				click_button 'Add To-do'
			}.to change(ToDo, :count).by 1
		end
  end
end
