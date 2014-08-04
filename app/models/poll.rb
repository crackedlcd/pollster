class Poll
	include Mongoid::Document
	embedded_in :question
	field :data
end
