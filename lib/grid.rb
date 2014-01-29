
class Grid 

	attr_accessor :cells

	def initialize(string)
		@cells = string.chars.map.with_index{|value, index| Cell.new(value, index)} 
		find_neighbours
	end

	def solved?
		cells.all?{|cell| cell.solved?}
	end

	def find_neighbours
		# iterate over rows, columns and boxes and assign their elements to be neighbours
		cells.each_slice(9).map{|i| i}.each do |row| 
			row.combination(2).to_a.each do |cells|
		 			cells.first.add_neighbour(cells.last.value) 
		 			cells.last.add_neighbour(cells.first.value)
		 	end
		end

		cells.each_slice(9).map{|i| i}.transpose.each do |row| 
			row.combination(2).to_a.each do |cells|
		 			cells.first.add_neighbour(cells.last.value) 
		 			cells.last.add_neighbour(cells.first.value)
		 	end
		end

		cells.each_slice(9).map{|x| x.each_slice(3).to_a}.transpose.flatten.each_slice(9).to_a.each do |box|
			box.combination(2).to_a.each do |cells|
		 			cells.first.add_neighbour(cells.last.value) 
		 			cells.last.add_neighbour(cells.first.value)
		 	end
		end
	end

	def try_to_solve
		cells.each{|cell| cell.solve}
		find_neighbours
	end

	def solve
		outstanding_before = cells.size
		looping = false

		while !solved? && !looping 
			try_to_solve
			outstanding = @cells.count{|c| c.solved?}
			looping = outstanding == outstanding_before
			outstanding_before = outstanding
		end		
	end

	def inspect
		output = ""
		a = @cells.map{|cell| cell.value.to_i}.each_slice(3).to_a
		3.times{3.times{output<<(a.shift(3).inspect)+"\n"}; output<<"\n" }
		output
	end

	def to_s
		@cells.map{|cell| cell.value.to_i}.join
	end

end
