# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  name            :string(255)
#

class User < ActiveRecord::Base
  has_many :scorecards, dependent: :destroy
  has_one :routine, dependent: :destroy
  
  before_create do 
    self.email = email.downcase
  end
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }

  has_secure_password

  attr_accessor :current_scorecards

  def no_scores?
    !self.scorecards.any? {|scorecard| scorecard.score4 || scorecard.score60 || scorecard.score5 }
  end
end
