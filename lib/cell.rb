class Cell 

	attr_accessor :value, :neighbours

	def initialize(value, position)
		@value = value
		@position = position
		@neighbours = []
	end

	def filled_out?
		@value && @value != "0" 
	end

	def candidates
		("1".."9").to_a - neighbours_values
	end

	def add_neighbour(line)
		@neighbours << line
	end 
 	
 	def solve
 		return if solved?
 		@value = candidates.first if candidates.size == 1
 	end

 	def solved?
 	 	filled_out?
 	end

 	def assume(string)
 		@value = string 
 	end

 	def neighbours_values
 		@neighbours.flatten.map{|cell| cell.value}.uniq.reject{|value| value == "0" }
 	end



end
