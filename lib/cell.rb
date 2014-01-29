

class Cell 

	attr_accessor :value, :neighbours

	def initialize(value, position)
		@value = value
		@position = position
		@neighbours = []
	end

	def filled_out?
		return false if value.nil? 
		return false if value == "0"
		return true 
	end

	def candidates
		("1".."9").to_a - neighbours
	end

	def add_neighbour(neighbour)
		return if neighbour == "0" || @neighbours.include?(neighbour) || neighbour == @value 
		@neighbours << neighbour
	end 
 	
 	def solve
 		return if solved?
 		@value = candidates.first if candidates.size == 1
 	end

 	def solved?
 	 	filled_out?
 	end

 	def assume(string)
 		@value = string #if @neighbours.include?(string)
 	end


end
