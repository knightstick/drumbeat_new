class User < ActiveRecord::Base
  has_many :scorecards
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }

  has_secure_password

  def self.make(params)
    user = User.new(params)
    user.daily_exercise = Exercise.random_exercise.try(:id)
    user.daily_updated_at = Time.now
    user
  end

  def needs_new_daily?
    daily_updated_at.nil? || daily_updated_at < (DateTime.now - 24.hours)
  end
  
  def assign_new_daily
    assign_daily(assign: true)
  end
  
  def assign_daily(options = {})
    if self.needs_new_daily? || options[:assign]
      update_attributes(daily_exercise: Exercise.random_exercise.id, daily_updated_at: Time.now)
    else
      false
    end
  end
  
  def daily_scorecard
    Scorecard.get(self.daily_exercise, self.id )
  end

end
