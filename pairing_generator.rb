require 'yaml'

class PairCreator

  VALID_COHORTS = ['january', 'february', 'march', 'april', 'may','june','july','august','september', 'october','novermber', 'december']
  attr_reader :cohort, :all_students, :historic_pairs

  def initialize cohort
    @cohort = cohort
    @all_students = YAML.load_file("./cohorts/#{@cohort}.yml")
    @historic_pairs = Dir["./pairs/#{cohort}-*.yml"].map {|file| YAML.load_file(file) }.inject([]){|m,a| m + a} rescue []
  end

  def self.call cohort
    raise "You need to supply a cohort" unless VALID_COHORTS.include?(cohort)
    new(cohort).call
  end

  def all_pairs
    all_students.combination(2).map{|pair|pair.sort}.to_a
  end

  def save_to_file(day_pairs)
    File.write("./pairs/#{cohort}-#{Time.now.strftime("%Y-%d-%m")}-#{rand(10 * 10 * 10)}.yml", day_pairs.to_yaml)
  end

  def call
    save_to_file(generate_new_pairs)
  end

  def generate_new_pairs
    day_pairs = []
    day_pairs = all_pairs.select do |pair|
      day_pairs << pair unless (day_pairs.flatten.include?(pair.first)) || (day_pairs.flatten.include?(pair.last)) || historic_pairs.include?(pair)
    end
  end

end

