require_relative "player"

class ComputerPlayer < Player
	attr_accessor :difficulty

	def initialize(opponent_piece)
		@difficulty = "easy"
		if opponent_piece == "X"
			@piece = "O"
		else
			@piece = "X"
		end
	end

	def set_difficulty
		puts "Please enter a difficulty level - easy, medium, or hard:"
		input = gets.chomp
		if input == "easy"
			@difficulty = "easy"
		elsif input == "medium"
			@difficulty = "medium"
		elsif input == "hard"
			@difficulty = "hard"
		else
			puts "Invalid input."
			set_difficulty
		end
	end
end


