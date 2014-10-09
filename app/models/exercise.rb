# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sticking   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  image_url  :string(255)
#  tier       :integer
#

class Exercise < ActiveRecord::Base
  validates :name, presence: true

  has_many :scorecards, dependent: :destroy
  
  def image_file
    "#{self.dashify}.gif"
  end
  
  def dashify
    self.name.downcase.split(' ').join('-')
  end
  
  def self.random_exercise
    ids = Exercise.all().map {|exercise| exercise.id }
    id = ids[rand(0...ids.length)]
    Exercise.find(id)
  end

  def self.tier(i)
    Exercise.where(tier: i)
  end

  def self.tiered
    tiered = {}
    (1..4).each do |i|
      tiered["tier#{i}".to_sym] = Exercise.tier(i) 
    end
    tiered
  end
end
