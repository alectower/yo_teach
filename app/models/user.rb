class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :name, :email
  validates_presence_of :password, :password_confirmation,
    on: [:create]
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A.+@.+\..+\Z/

  has_one :account
  has_many :courses
  has_many :lesson_plans
  has_many :to_dos
end
