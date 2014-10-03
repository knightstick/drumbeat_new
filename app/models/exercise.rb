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
  
  def image_url
    "http://www.freedrumlessons.com/media/drum-lessons/drum-rudiments/#{self.dashify}-1.gif"
  end
  
  def dashify
    self.name.downcase.split(' ').join('-')
  end
  
  def self.random_exercise
    Exercise.where(id: rand(1..Exercise.count)).first
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
