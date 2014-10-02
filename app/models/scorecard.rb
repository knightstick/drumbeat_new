# == Schema Information
#
# Table name: scorecards
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  exercise_id :integer
#  score4      :integer
#  created_at  :datetime
#  updated_at  :datetime
#  score60     :integer
#  score5      :integer
#

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
  
  def self.get(exercise_id, user_id)
    scorecard = Scorecard.where(exercise_id: exercise_id, user_id: user_id).last
    if scorecard.nil?
      scorecard = Scorecard.create(exercise_id: exercise_id, user_id: user_id)
    end
    scorecard
  end
end
