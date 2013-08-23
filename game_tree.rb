require_relative 'game'

class GameTree
	attr_accessor :parent
	attr_accessor :game
	attr_accessor :first_child
	attr_accessor :first_sibling
	attr_accessor :depth
	attr_accessor :player

	def initialize(parent = nil, game = nil)
		@parent = parent
		@game = game
		@first_child = nil
		@first_sibling = nil
	end

	def insert_child(game)
		next_node = GameTree.new(self, game)
		if @first_child == nil
			@first_child = next_node
		else
			@first_child.insert_sibling next_node
		end
	end

	def insert_sibling(node)
		if @first_sibling == nil
			@first_sibling = node
		else
			@first_sibling.insert_sibling node
		end
	end

	def get_children()
		child_list = []
		if @first_child != nil
			child_list.push(first_child)
		end
		if @first_child.first_sibling != nil
			other_children = @first_child.first_sibling.get_siblings
			child_list = child_list.concat(other_children)
		end
		return child_list
	end

	def get_siblings()
		sibling_list = [self]
		if @first_sibling == nil
			return sibling_list
		else
			sub_siblings = @first_sibling.get_siblings
			sibling_list = sibling_list.concat(sub_siblings)
		end
		return sibling_list
	end

	def traverse_tree()
		list = []
		if @first_child != nil
			list.push(@first_child)
			children = @first_child.traverse_tree
			list = list.concat(children)
		end
		if @first_sibling != nil
			list.push(@first_sibling)
			siblings = @first_sibling.traverse_tree
			list = list.concat(siblings)
		end
		return list
	end

	def create_game_tree(depth)
		@player = @game.current_player

		game_states = create_duplicate_states(@game, 7)
		game_states.each_with_index do |game_state, index|
			move = index + 1
			game_state.place_move(move, @player)
			insert_child game_state
		end

		if depth != 0
			depth = depth - 1
			children = get_children
			children.each do |child|
				child.create_game_tree(depth)
			end
		else
			return
		end
	end

	def create_duplicate_states(game, number)
		states = []
		number.times do
			states.push(game.clone)
		end
		return states
	end
end

