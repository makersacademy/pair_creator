require 'yaml'

cohort = "june"

all_students = YAML.load_file("./cohorts/#{cohort}.yml")
historic_pairs = Dir["./pairs/#{cohort}-*.yml"].map {|file| YAML.load_file(file) }.inject([]){|m,a| m + a} rescue []

all_pairs = all_students.combination(2).map{|pair|pair.sort}.to_a

day_pairs = []
day_pairs = all_pairs.select do |pair|
  day_pairs << pair unless (day_pairs.flatten.include?(pair.first)) || (day_pairs.flatten.include?(pair.last)) || historic_pairs.include?(pair)
end

File.write("./pairs/#{cohort}-#{Time.now.strftime("%Y-%d-%m")}-#{rand(10 * 10 * 10)}.yml", day_pairs.to_yaml)

