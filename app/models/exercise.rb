class Exercise < ActiveRecord::Base
  has_many :scorecards
  
  def image_url
    "http://www.freedrumlessons.com/media/drum-lessons/drum-rudiments/#{self.dashify}-1.gif"
  end
  
  def dashify
    self.name.downcase.split(' ').join('-')
  end
end
