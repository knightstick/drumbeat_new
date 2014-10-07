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
  has_many :scorecards, dependent: :destroy
  
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

  attr_accessor :current_scorecards

  def needs_new?(options = {})
    timeframe = options[:timeframe] ||= 'daily'
    times = {daily: 24.hours, weekly: 7.days, monthly: 1.month}
    self.send("#{timeframe}_updated_at").nil? || self.send("#{timeframe}_updated_at") < (DateTime.now - times[timeframe.to_sym])
  end
  
  def method_missing(name, *args)
    if name =~ /needs_new/
      timeframe = name.to_s.split("_")[-1].slice(0...-1)
      self.send("needs_new?", timeframe: timeframe)
    else
      super
    end
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
