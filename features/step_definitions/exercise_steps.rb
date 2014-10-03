require 'cucumber/rspec/doubles'

Given(/^there are (\d+) additional exercises$/) do |n|
  2.upto(n.to_i) do |i|
    Exercise.create!(name: "Single Stroke #{i}")
  end
end

Given(/^Random Exercise returns (\d+)$/) do |n|
  Exercise.should_receive(:random_exercise).at_least(1).times.and_return(Exercise.find(n))
end