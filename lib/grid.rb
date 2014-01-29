
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

		cells.each_slice(9).map{|i| i}.transpose.each do |column|
			column.combination(2).to_a.each do |cells|
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
		cells.each do |cell| 
			cell.solve
			find_neighbours if cell.solved?
		end

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
		
		#puts "easy solve done"	
		#puts self.inspect

		#try_harder unless solved?

	end

	def try_harder

		#select an unsolved cell with fewest number of candidates
		blank_cell = cells.select{|cell| !cell.solved?}.min_by{|cell| cell.candidates.size}

		#puts blank_cell.inspect
		#puts blank_cell.candidates.inspect

		blank_cell.candidates.each do |candidate|
			
			blank_cell.assume(candidate)
			find_neighbours
			#puts blank_cell.inspect
			#puts candidate

			board = self.replicate

			#puts board.inspect
			#puts ""

			board.solve
			
			#puts board.inspect
			#puts ""

			steal_solution(board) and return if board.solved?
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

	def replicate
		Grid.new(self.to_s)
	end

	def steal_solution(board)
		@cells = board.cells
		find_neighbours
	end

end
