class Question
  include Mongoid::Document
  include Mongoid::Slug

  field :content
  slug :content
  
  embeds_many :poll
  accepts_nested_attributes_for :poll
  field :answers, :type => Array, default: []
  field :data_table, :type => Hash

  def answers_list=(arg)
  	self.answers = arg.split(',').map { |v| v.strip }
  end

  def answers_list 
  	self.answers.join(', ')
  end

  def create_data_table
    self.data_table = Hash.new 0

    answers.each do |ans|
      self.data_table[ans] = 0
    end
  end

  def add_to_data_table(ans)
    self.data_table[ans] = self.data_table[ans] + 1 unless self.data_table[ans].nil?
    self.save
  end
end