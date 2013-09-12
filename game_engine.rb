# Display with directions (player vs. computer for now)
# Initialize user player and pick 'X' or 'O'
# Pick level of difficulty of computer player
# Initialize computer player
# Display empty board with instructions for input
# Get input from the user
# Place corresponding move onto the board
# Check for winner
# Tell computer to calculate next move
# Computer picks a move
# Add that move to the board
# Check for winner
# Get input from the user
# If there is a winner, output "You won!" message

require_relative 'output_writer'
require_relative 'game'
require_relative 'player'
require_relative 'computer_player'
require_relative 'test_helpers'
require_relative 'game_tree'

# Display with directions (player vs. computer for now)
output = OutputWriter.new
output.display_game_instructions

# Pick 'X' or 'O'
player = Player.new
player.pick_piece

# Pick level of difficulty of computer player
# Initialize computer player
computer_player = ComputerPlayer.new(player.piece)
# computer_player.set_difficulty

# Create a game and display empty board with directions for input
game = Board.new(player, computer_player)

# Display input instructions
output.display_input_instructions(game)

game_over = false

until game_over do
	# Display the board
	output.display_board(game)

	# Get input from the user
	player_move = player.get_move

	# Place corresponding move onto the board
	game.place_move(player_move, player)

	# Check if the last piece played is a winner is_winner?(move)
	game_over = game.is_winner?
	if game_over
		break
	end

	# Create a game tree of all possible computer responses of depth 3
	game_tree = GameTree.new(nil, game)
	game_tree.create_game_tree(3)

	# Tell computer to calculate next move
	current_rank, computer_ranked_move = computer_player.choose_move(game_tree)
	if computer_ranked_move.rank == 0 # 	&& game.move_hash.length < 5
		computer_move = 2 + rand(3)
	else
		computer_move = computer_ranked_move.move[0][0]
	end
	game.place_move(computer_move, computer_player)

	# Check if the last piece played is a winner is_winner?(move)
	game_over = game.is_winner?
end

puts "Game over!"
output.display_board(game)
puts "#{game.last_player.piece} won!"
puts "#{game.last_move}"
puts 
