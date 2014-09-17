class Scorecard < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  
  def submit_score(scores = {})
    scores.each do |key, value|
      if value.to_i > self.send(key.to_sym)
        update(key.to_sym => value) unless value.blank?
      end
    end
  end
end
