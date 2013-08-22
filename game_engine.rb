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

# Display with directions (player vs. computer for now)
writer = OutputWriter.new
writer.display_game_instructions

# Pick 'X' or 'O'
player = Player.new
player.pick_piece

# Pick level of difficulty of computer player
# Initialize computer player
computer_player = ComputerPlayer.new(player.piece)
computer_player.set_difficulty

# Create a game and display empty board with directions for input
game = Game.new(player, computer_player)

# Display input instructions
output.display_input_instructions(game)

# Get input from the user
player_move = player.get_move

# Place corresponding move onto the board
game.place_move(player_move, player)

# Check if the last piece played is a winner is_winner?(move)
game_over = game.is_winner?

# Tell computer to calculate next move
computer_move = computer_player.pick_next_move

