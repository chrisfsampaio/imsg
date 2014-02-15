class Participant
	attr_accessor :name

	def initialize(name)
		self.name = name
	end

	def self.from_ascript_participant(ascript_participant)
		self.new(ascript_participant.name.get())
	end
end