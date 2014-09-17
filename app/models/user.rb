class User < ActiveRecord::Base
  has_many :scorecards
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }

  
  has_secure_password
  
  def set_daily_exercise
    self.daily_exercise = rand(1..Exercise.count)
    self.save(validate: false)
  end
  
  def needs_new_daily?
    
    daily_updated_at ||= created_at  < (DateTime.now - 24.hours)
  end
  
  def assign_daily(options = {})
    return self.daily_scorecard unless self.needs_new_daily? || options[:assign] == true
    
    # pick an exercise from the collection
    random_exercise = Exercise.random_exercise
    
    scorecard = Scorecard.find_by(user_id: self.id, 
                                exercise_id: random_exercise.id)
    if  scorecard.nil?
      scorecard = Scorecard.create!(user_id: self.id, exercise_id: random_exercise.id)
      # "/users/#{self.id}/scorecards/#{new_card.id}"
    end
    self.update_attributes(daily_exercise: scorecard.exercise.id)
    self.update_attributes(daily_updated_at: Time.now)
    scorecard
  end
  
  def daily_scorecard
    Scorecard.where(user_id: self.id, exercise_id: self.daily_exercise).first
  end
end
