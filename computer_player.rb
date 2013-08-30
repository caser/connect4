require_relative "player"

class RankedMove
	attr_accessor :game_state
	attr_accessor :player
	attr_accessor :rank
	attr_accessor :beta
	attr_accessor :move

	def initialize(move, player, rank)
		@move = move
		@player = player
		@rank = rank
	end
end

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

		game_state = game_tree.game
		first_child = game_tree.first_child
		first_sibling = game_tree.first_sibling
		best_move = []
		best_reply = ""

		ranked_self = RankedMove.new(game_state.last_move, game_state.last_player, 0)

		if side == "COMPUTER"
			opponent = "HUMAN"
			best_rank = -20
		else
			opponent = "COMPUTER"
			best_rank = 20
		end

		if first_child == nil
			ranked_move = rank_state(game_state)
			return ranked_move
		else
			children = game_tree.get_children
			ranked_children = []
			children.each do |child|
				ranked_move, ranked_reply = choose_move(child, opponent)
				ranked_children.push(ranked_move)
			end

			ranked_children.each do |ranked_child|
				if side == "COMPUTER" && ranked_child.rank > best_rank
					best_reply = ranked_child
					best_rank = ranked_child.rank
				elsif side == "HUMAN" && ranked_child.rank < best_rank
					best_reply = ranked_child
					best_rank = ranked_child.rank
				end
			end
			ranked_self.rank = best_rank
			return ranked_self, best_reply
		end
			# Should return the best move out of all the game_states in the game_tree
		
	end

	def rank_state(game_state)
		rank = 0
		if game_state.is_winner? && game_state.last_player.type == "computer"
			rank = 10
			ranked_move = RankedMove.new(game_state.last_move, game_state.last_player, rank)
			return ranked_move
		elsif game_state.is_winner? && game_state.last_player.type == "human"
			rank = -10
			ranked_move = RankedMove.new(game_state.last_move, game_state.last_player, rank)
			return ranked_move
		else
			player1_threes, player2_threes = game_state.count_open_threes
			rank = player2_threes - player1_threes
			ranked_move = RankedMove.new(game_state.last_move, game_state.last_player, rank)
			return ranked_move
		end
	end
end


