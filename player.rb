class Player
	attr_accessor :piece

	def initialize
		@piece = "X"
	end

	def pick_piece
		puts "Would you like to be 'X' or 'O'?"
		puts "Enter your choice below:"
		self.get_piece
	end

	def get_piece
		piece = gets.chomp
		if piece.downcase == "x"
			@piece = "X"
		elsif piece.downcase == "o" || piece == "0"
			@piece = "O"
		else
			puts "Please enter either 'X' or 'O' to choose a piece:"
			self.get_piece
		end
	end

	def get_move
		puts "Please enter a number 1-7 to indicate the column in which you would like to place your next piece."
		move = gets.chomp.to_i
		allowable_moves = [1, 2, 3, 4, 5, 6, 7]
		if allowable_moves.include? move
			move
		else
			puts "Invalid input."
			get_move
		end
	end
end