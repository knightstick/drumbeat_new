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

  def needs_new_weekly?
    weekly_updated_at.nil? || weekly_updated_at < (DateTime.now - 7.days)
  end

  def needs_new_monthly?
    monthly_updated_at.nil? || monthly_updated_at < (DateTime.now - 1.month)
  end
  
  def assign_new_daily
    assign_daily(force: true)
  end

  def assign_new_weekly
    assign_weekly(force: true)
  end

  def assign_new_monthly
    assign_monthly(force: true)
  end
  
  def assign_daily(options = {})
    if self.needs_new_daily? || options[:force]
      if options[:exercise].present?
        assign(options[:exercise], "daily")       
      else
        assign(Exercise.random_exercise.id, "daily")
      end
    else
      false
    end
  end

  def assign_weekly(options = {})
    if self.needs_new_weekly? || options[:force]
      if options[:exercise].present?
        assign(options[:exercise], "weekly")       
      else
        assign(Exercise.random_exercise.id, "weekly")
      end
    else
      false
    end
  end

  def assign_monthly(options = {})
    if self.needs_new_monthly? || options[:force]
      if options[:exercise].present?
        assign(options[:exercise], "monthly")       
      else
        assign(Exercise.random_exercise.id, "monthly")
      end
    else
      false
    end
  end  

  
  def daily_scorecard
    Scorecard.get(self.daily_exercise, self.id )
  end

  def no_scores?
    self.scorecards.each do |scorecard|
      return false if scorecard.score4 || scorecard.score60 || scorecard.score5
    end
    return true
  end

  private
    def assign(exercise, timeframe = "daily")
      # options: timeframe, exercise
      update_attributes("#{timeframe}_exercise".to_sym => exercise, "#{timeframe}_updated_at".to_sym => Time.now)
    end
end
