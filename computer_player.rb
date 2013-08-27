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
		@type = "computer"
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

	def choose_move(game_tree, side = 'COMPUTER')
		# Write code to traverse game tree and choose the next best move
		# Sample heuristic - three in a row, 2 in a row with open spaces, etc.
		all_nodes = game_tree.traverse_tree



		# Write method to rank game state
		
	end

	def rank_state(game)
		rank = 0
		if game.last_move.is_winner?
			return rank = 10
		else

		end
	end
end


