require_relative 'output_writer'
require_relative 'game'
require_relative 'player'
require_relative 'computer_player'
require_relative 'test_helpers'

# This file is used to test during development without using a framework such as RSPEC

def test(type)
	test_type = type
	if test_type == "before"
		# TESTED ALREADY

		# Test that game instructions are displayed
		output = OutputWriter.new
		output.display_game_instructions

		# Test that player is initialized and test method for user to choose a piece
		player = Player.new
		player.which_piece?
		puts "Your piece is: #{player.piece}"

		# Test that computer player is initialized with the opposite piece of the human user
		# Test the method to set the computer's difficulty level
		computer_player = ComputerPlayer.new("X")
		computer_player.set_difficulty
		puts "Difficulty is #{computer_player.difficulty}"

		# Test creation of sample board (no gravity)
		helper = TestHelpers.new
		sample_board_array = helper.create_sample_board_array
		sample_board_array.each do |row|
			puts row.inspect
		end

		# Test display of sample board
		sample_board_array = create_sample_board_array
		output.display_board(sample_board_array)

		# Test board initialization and display of empty board
		game = Board.new(player, computer_player)
		output.display_board(game.board_array)

		# Test display of input instructions
		output.display_input_instructions(game.board_array)

		# Test method that gets the user's next move as input
		next_move = player.get_move
		puts "The next move is: #{next_move}"

		# Test method to add move to the board & method to add to the hash of all moves
		game.place_move(5, player)
		puts output.display_board(game)
		puts game.move_hash.inspect

		# Test method which checks the number of horizontal pieces in a row
		game.board_array = helper.create_sample_board_array
		puts "Board array is: #{game.board_array}"
		game.create_sample_data_from_array
		output.display_board(game)
		puts "Check vertical count of which move? Enter in split by commas."
		puts "I.e. 3, 4"
		input = gets.chomp.split(",").each do |character|
			character.strip!
		end
		coordinates = [input[0].to_i, input[1].to_i]
		piece = game.move_hash[coordinates]
		move = [coordinates, piece]
		vertical_count = game.count_vertical(move)
		puts "The number of vertical pieces in a row is: #{vertical_count}"
		horizontal_count = game.count_horizontal(move)
		puts "The number of horizontal pieces in a row is: #{horizontal_count}"
		diagonal_count = game.count_diagonal(move)
		puts "The number of diagonal pieces in a row is: #{diagonal_count}"

		# Test is_winner? method
		game_over = false
		until game_over do
			output.display_board(game)
			player_move = player.get_move
			game.place_move(player_move, player)
			game_over = game.is_winner?
		end
		output.display_board(game)
		puts "Game over! #{game.last_move[1]} has won!"		


	elsif test_type == "new"
		output = OutputWriter.new
		player = Player.new
		computer_player = ComputerPlayer.new(player.piece)
		game = Board.new(player, computer_player)
		helper = TestHelpers.new

		# NEXT THING TO TEST
		



	else
		puts "Enter a valid test-type."
	end
end

test("new")