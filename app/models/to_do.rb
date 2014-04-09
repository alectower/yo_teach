class ToDo < ActiveRecord::Base
  validates_presence_of :body, :user
  belongs_to :user
end
