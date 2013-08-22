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
end
