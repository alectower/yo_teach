require 'spec_helper'

describe "ToDos" do
  describe "GET /to_dos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get to_dos_path
      response.status.should be(200)
    end
  end
end
