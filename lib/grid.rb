class Grid 

	attr_accessor :cells

	def initialize(string)
		initialize_cells(string)
	end

	def initialize_cells(string)
		cells = string.chars.map.with_index{|value, index| Cell.new(value, index)}
		rows = rows(cells)
		columns = columns(cells)
		boxes = boxes(cells)

		[columns, rows, boxes].each do |element|
			element.each do |line| 
				line.each do |cell|
					cell.add_neighbour(line)
				end
			end
		end

		@cells = cells
	end

	def solved?
		@cells.all?{|cell| cell.solved?}
	end

	def rows(cells)
		cells.each_slice(9).map{|i| i}
	end

	def columns(cells)
		cells.each_slice(9).map{|i| i}.transpose
	end

	def boxes(cells)
		cells.each_slice(9).map{|x| x.each_slice(3).to_a}.transpose.flatten.each_slice(9).to_a
	end

	def try_to_solve
		@cells.each{|cell| cell.solve unless cell.solved? }
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

		try_harder unless solved?

	end

	def try_harder

		#select an unsolved cell with fewest number of candidates
		blank_cell = cells.select{|cell| !cell.solved?}.min_by{|cell| cell.candidates.size}

		blank_cell.candidates.each do |candidate|
			
			blank_cell.assume(candidate)
			board = replicate
			board.solve
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
		initialize_cells(board.to_s)	
	end

end
