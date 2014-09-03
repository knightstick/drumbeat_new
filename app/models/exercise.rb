class Exercise < ActiveRecord::Base
  
  def image_url
    "http://www.freedrumlessons.com/media/drum-lessons/drum-rudiments/#{self.dashify}-1.gif"
  end
  
  def dashify
    self.name.downcase.split(' ').join('-')
  end
end
