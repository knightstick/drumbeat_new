# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  password_digest    :string(255)
#  name               :string(255)
#  daily_exercise     :integer
#  daily_updated_at   :datetime
#  weekly_exercise    :integer
#  monthly_exercise   :integer
#  weekly_updated_at  :datetime
#  monthly_updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :scorecards
  
  before_create do 
    self.email = email.downcase
    self.daily_exercise = Exercise.random_exercise.try(:id)
    self.daily_updated_at = Time.now
  end
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
    uniqueness: { case_sensitive: false }

  has_secure_password

  def needs_new_daily?
    daily_updated_at.nil? || daily_updated_at < (DateTime.now - 24.hours)
  end

  def needs_new_weekly?
    weekly_updated_at.nil? || weekly_updated_at < (DateTime.now - 7.days)
  end

  def needs_new_monthly?
    monthly_updated_at.nil? || monthly_updated_at < (DateTime.now - 1.month)
  end
  
  def daily_scorecard
    Scorecard.find_or_create_by(exercise_id: self.daily_exercise, user_id: self.id )
  end

  def no_scores?
    !self.scorecards.any? {|scorecard| scorecard.score4 || scorecard.score60 || scorecard.score5 }
  end


  def assign_scorecard(options = {})
    assign_options = {}
    assign_options[:exercise] = options[:exercise]||= Exercise.random_exercise.id
    assign_options[:timeframe] = options[:timeframe] ||= 'daily'
    assign(assign_options)
  end

  private
    def assign(options = {})
      self.update!("#{options[:timeframe]}_exercise" => options[:exercise])
      self.update!("#{options[:timeframe]}_updated_at" => Time.now)
    end
end
