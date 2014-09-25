class Exercise < ActiveRecord::Base
  has_many :scorecards
  
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
