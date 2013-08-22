class OutputWriter
	attr_accessor :message

	def initialize
		@message = ""
	end

	def display_game_instructions
		puts "\nWelcome to Command Line Connect4\n\n"
		puts "The goal of the game is to line up 4 of your pieces in a row."
		puts "Like in tic-tac-toe, diagonals, horizontals, and verticals all count."
		puts "Unlike in tic-tac-toe, the board fills from the bottom up."
		puts "This means that you pick a column, and your piece comes in on top of all other"
		puts "pieces in that column. In other words, at the lowest unoccupied position.\n\n"
		puts "Type \'help\' at any time to display these instructions again.\n\n"
		puts "You will be playing against a computer. Make humanity proud.\n"
	end

	def display_input_instructions(game)
		board_array = game.board_array
		empty_board = board_array
		not_so_empty_board = empty_board.dup
		not_so_empty_board[5] = [" ", " ", " ", " ", " ", "X", " "]

		board_1 = stringify_board(empty_board)
		board_2 = stringify_board(not_so_empty_board)

		output = []
		board_1.length.times do |i|
			if i < board_1.length-1
				string = board_1[i] + "          " + board_2[i]
			else
				string = board_1[i] + "           " + board_2[i]
			end
			output.push(string)
		end

		puts "\nHere are two sample boards:\n\n"

		output.each do |line|
			puts line
		end

		puts "\nOn the left is an empty board from the beginning of a game."
		puts "\nYou make your move by typing in the column that you'd like to play in."
		puts "Sample input: 6\n\n"
		puts "After you type in your move, it will appear in the lowest empty space in that column."
		puts "The board on the right shows the result of typing in '6' as your move."
		puts "\nThe game has 'gravity', so your piece will always occupy the lowest space in the column you choose."
	end

	def stringify_board(board_array)
		output_string_array = []

		board_array.each do |row|
			string = "        | " + row.join(" ") + " |"
			output_string_array.push(string)
		end

		base = "        | - - - - - - - |"
		output_string_array.push(base)

		labels = " Columns: 1 2 3 4 5 6 7 "
		output_string_array.push(labels)
		output_string_array
	end

	def display_board(game)
		board_array = game.board_array
		output_board = stringify_board(board_array)
		puts "\n Current board:\n\n"
		output_board.each do |line|
			puts line
		end
		puts "\n"
	end
end