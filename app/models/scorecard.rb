class Scorecard < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  
  SCORES = [:score4, :score60, :score5]
  
  def submit_score(scores = {})
    scores.each do |key, value|
      
      if self.send(key.to_sym).nil? || value.to_i > self.send(key.to_sym)
        update(key.to_sym => value) unless value.blank?
      end
    end
  end
  
  def reset_scores
    SCORES.each do |score|
      update(score => nil) 
    end
  end
end
