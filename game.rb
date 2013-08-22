class Board
	attr_accessor :board_array
	attr_accessor :move_hash
	attr_accessor :player1
	attr_accessor :player2
	attr_accessor :last_move

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2

		@board_array = []
		6.times do |x|
			@board_array.push(Array.new(7, " "))
		end
		
		@last_move = []
		@move_hash= {}

		@next_player = player2
	end

	def place_move(move, player)
		piece = player.piece
		placed = false
		column = (move - 1).to_i
		6.times do |i|
			index = (5 - i).to_i
			if @board_array[index][column] == " "
				@board_array[index][column] = piece
				indices = [i + 1, column + 1]
				move_hash[indices] = piece
				@last_move = [indices, piece]
				placed = true
				break
			else
				next
			end
		end
		placed
	end

	def is_winner?()
		move = @last_move
		vertical = count_vertical(move)
		horizontal = count_horizontal(move)
		diagonal = count_diagonal(move)

		max_in_a_row = [vertical, horizontal, diagonal].max

		if max_in_a_row >= 4
			return true
		else
			return false
		end
	end

	def count_vertical(move)
		count = 1
		up = 0
		down = 0

		up = count_next(move, "up")
		down = count_next(move, "down")

		total_count = count + up + down
	end

	def count_horizontal(move)
		count = 1
		left = 0
		right = 0

		left = count_next(move, "left")
		right = count_next(move, "right")

		total_count = count + left + right
	end

	def count_diagonal(move)
		count = 1

		diagonal_pos = 0
		diagonal_neg = 0

		diagonal_pos = count_next(move, "diagonal_pos_up") + count_next(move, "diagonal_pos_down")
		diagonal_neg = count_next(move, "diagonal_neg_up") + count_next(move, "diagonal_neg_down")

		max_diag = [diagonal_pos, diagonal_neg].max

		total_count = count + max_diag
	end

	def count_next(move, direction)
		count = 0
		next_count = 0
		x, y, piece = move_details(move)
		next_coords = calc_next_coords(x, y, direction)

		if move_hash[next_coords] != piece
			next_count = 0
		else
			count = 1
			next_move = [next_coords, piece]
			next_count = count_next(next_move, direction)
		end
		total_count = count + next_count
		return total_count
	end

	def calc_next_coords(x, y, direction)
		case direction
		when "left"
			[x-1, y]
		when "right"
			[x+1, y]
		when "up"
			[x, y+1]
		when "down"
			[x, y-1]
		when "diagonal_pos_up"
			[x+1, y+1]
		when "diagonal_pos_down"
			[x-1, y-1]
		when "diagonal_neg_up"
			[x-1, y+1]
		when "diagonal_neg_down"
			[x+1, y-1]
		end
	end

	def move_details(move)
		x = move[0][0]
		y = move[0][1]
		piece = move[1]
		return x, y, piece
	end

	def create_sample_data_from_array()
		@board_array.each_with_index do |row, outer_index|
			row.each_with_index do |move, inner_index|
				x = inner_index + 1
				y = @board_array.length - outer_index
				@move_hash[[x, y]] = move
			end
		end
	end
end