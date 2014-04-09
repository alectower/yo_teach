class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :password, on: :create
  validates_format_of :email, with: /\A.+@.+\..+\Z/

  has_many :courses
  has_many :lesson_plans
  has_many :to_dos
end
