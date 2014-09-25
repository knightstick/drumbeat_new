module ScorecardsHelper
	def dash_nils(string)
		return string unless string.nil?
		"-"
	end
end
