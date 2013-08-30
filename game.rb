class Board
	attr_accessor :board_array
	attr_accessor :move_hash
	attr_accessor :player1
	attr_accessor :player2
	attr_accessor :last_move
	attr_accessor :last_player
	attr_accessor :current_player

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2

		@board_array = []
		6.times do |x|
			@board_array.push(Array.new(7, " "))
		end
		
		@last_move = []
		@move_hash= {}

		@current_player = player1
	end

	def place_move(move, player)
		piece = player.piece
		placed = false
		column = move - 1
		6.times do |i|
			index = 5 - i
			if @board_array[index][column] == " "
				@board_array[index][column] = piece
				indices = [column + 1, i + 1] 
				move_hash[indices] = piece
				@last_move = [indices, piece]
				@last_player = player
				# Set current player
				@current_player = player == player1 ? player2 : player1
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

	def count_vertical(move, type = nil)
		count = 1
		up = 0
		down = 0
		open_count = 0

		if type == nil
			up = count_next(move, "up")
			down = count_next(move, "down")
			return total_count = count + up + down
		else # elsif type == "open"
			up, open_up = count_next(move, "up", "open")
			down, open_down = count_next(move, "down", "open")
			total_count = count + up + down
			open_count = open_up + open_down
			return total_count, open_count
		end
	end

	def count_horizontal(move, type = nil)
		count = 1
		left = 0
		right = 0
		open_count = 0

		if type == nil
			left = count_next(move, "left")
			right = count_next(move, "right")
			return total_count = count + left + right
		else # elsif type == "open"
			left, open_left = count_next(move, "left", "open")
			right, open_right = count_next(move, "right", "open")
			total_count = count + left + right
			open_count = open_left + open_right
			return total_count, open_count
		end
	end

	def count_diagonal(move, type = nil)
		pos = count_diagonal_pos(move)
		neg = count_diagonal_neg(move)

		total = [pos, neg].max
		return total
	end

	def count_diagonal_pos(move, type = nil)
		count = 1

		diagonal_pos_up = 0
		diagonal_pos_down = 0	
		open_count = 0

		if type == nil
			diagonal_pos_up = count_next(move, "diagonal_pos_up")
			diagonal_pos_down = count_next(move, "diagonal_pos_down")
			return total_count = count + diagonal_pos_up + diagonal_pos_down
		else # elsif type == "open"
			diagonal_pos_up, open_up = count_next(move, "diagonal_pos_up", "open")
			diagonal_pos_down, open_down = count_next(move, "diagonal_pos_down", "open")
			diagonal_pos = diagonal_pos_up + diagonal_pos_down

			total_count = count + diagonal_pos
			open_count = open_up + open_down
			return total_count, open_count
		end
	end

	def count_diagonal_neg(move, type = nil)
		count = 1
		diagonal_neg_up = 0
		diagonal_neg_down = 0

		open_count = 0

		if type == nil
			diagonal_neg_up = count_next(move, "diagonal_neg_up")
			diagonal_neg_down = count_next(move, "diagonal_neg_down")
			total_count = count + diagonal_neg_up + diagonal_neg_down
			return total_count
		else # elsif type == "open"
			diagonal_neg_up, open_up = count_next(move, "diagonal_neg_up", "open")
			diagonal_neg_down, open_down = count_next(move, "diagonal_neg_down", "open")
 
			total_count = count + diagonal_neg_up + diagonal_neg_down
			open_count = open_up + open_down
			return total_count, open_count
		end
	end

	def count_next(move, direction, type = nil)
		count = 0
		next_count = 0
		open_count = 0
		x, y, piece = move_details(move)
		next_coords = calc_next_coords(x, y, direction)
		gap = 0

		if move_hash[next_coords] != piece
			if type != "gap"
				next_count = 0
			else
				x2, y2 = next_coords[0], next_coords[1]
				second_coords = calc_next_coords(x2, y2, direction)
				if move_hash[second_coords] == piece
					gap = 1
				end
			end
		else
			count = 1
			next_move = [next_coords, piece]
			if type == nil
				next_count = count_next(next_move, direction)
			elsif type == "open"
				next_count, open_count = count_next(next_move, direction, "open")
			end
		end

		total_count = count + next_count

		if type == nil
			return total_count
		elsif type == "open"
			if move_hash[next_coords] == nil && are_valid_coords?(next_coords)
				open_count = 1
			end
			return total_count, open_count
		elsif type == "gap"
			return gap
		end
	end

	def are_valid_coords?(next_coords)
		x = next_coords[0]
		y = next_coords[1]
		if x > 7 || x < 1
			return false
		end
		if y > 6 || y < 1
			return false
		end
		return true
	end

	def count_open_threes()
		player1_threes = 0
		player2_threes = 0

		# Get X threes
		@move_hash.each do |key, value|
			move = [key, value]
			x, y, piece = move_details(move)

			vertical = count_threes(move, "vertical")
			horizontal = count_threes(move, "horizontal")
			diagonal_pos = count_threes(move, "diagonal_pos")
			diagonal_neg = count_threes(move, "diagonal_neg")

			threes = vertical + horizontal + diagonal_pos + diagonal_neg

			if piece == player1.piece
				player1_threes += threes
			else
				player2_threes += threes
			end
		end
		player1_threes /= 3 # Divide to account for redundant counting - needs optimizing
		player2_threes /= 3 # Divide to account for redundant counting - needs optimizing

		return player1_threes, player2_threes
	end

	def count_threes(move, direction)
		count = 0
		open_count = 0
		open_threes = 0
		x, y, piece = move_details(move)

		case direction
		when "vertical"
			dir1 = "up"
			dir2 = "down"
			count, open_count = count_vertical(move, "open")
		when "horizontal"
			dir1 = "left"
			dir2 = "right"
			count, open_count = count_horizontal(move, "open")
		when "diagonal_pos"
			dir1 = "diagonal_pos_up"
			dir2 = "diagonal_pos_down"
			count, open_count = count_diagonal_pos(move, "open")
		when "diagonal_neg"
			dir1 = "diagonal_neg_up"
			dir2 = "diagonal_neg_down"
			count, open_count = count_diagonal_neg(move, "open")
		end

		if count == 3 && open_count > 0
			open_threes += open_count
		elsif count == 2
			gap1 = count_next(move, dir1, "gap")
			gap2 = count_next(move, dir2, "gap")
			open_threes += gap1 + gap2
		end
		return open_threes
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