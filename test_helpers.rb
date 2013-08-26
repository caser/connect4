require_relative 'game'

class TestHelpers
	def create_sample_board_array
		sample_board_array = []
		6.times do |y|
			row = []
			7.times do |x|
				num = rand(3)
				if num == 0
					row.push("X")
				elsif num == 1
					row.push("O")
				else
					row.push(" ")
				end
			end
			sample_board_array.push(row)
		end
		sample_board_array
	end

	def create_sample_game(player1, player2)
		game = Board.new(player1, player2)
		counter = 1
		player = player1
		(1..14).each do |x|
			if x % 2 == 0
				player = player1
			else
				player = player2
			end
			num = rand(7) + 1
			game.place_move(num, player)
		end
		return game
	end
end
