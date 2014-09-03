class Exercise < ActiveRecord::Base
  
  def dashify
    self.name.downcase.split(' ').join('-')
  end
end
