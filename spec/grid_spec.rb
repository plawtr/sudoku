require_relative "../lib/grid.rb"
require_relative "../lib/cell.rb"

describe Grid do 

let(:puzzle) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
let(:zero_puzzle) {'0'*81}
let(:grid) {Grid.new(puzzle)} 
let(:zero_grid) {Grid.new(zero_puzzle)} 
let(:solved_grid) {Grid.new('615493872348127956279568431496832517521746389783915264952681743864379125137254698')}

	it "initializes with a string of 81 values" do
		expect(grid.cells.map{|cell| cell.value}.join).to eq(puzzle) 
	end

	it "has a method to solve the puzzle" do  
		expect{grid.solve}.not_to raise_error(Exception)
	end

	it "finds no cells' neighbours' values for a zero string" do
		expect(zero_grid.cells.first.neighbours).to eq([])
	end

	it "finds all cells' neighbours' values for a non-zero string" do
		expect(grid.cells.first.neighbours.sort).to eq(["1", "2", "3", "4", "5", "7", "8", "9"])
		expect(grid.cells[3].neighbours.sort).to eq([ "1", "2", "3", "5", "6", "8", "9"])
		expect(grid.cells.last.neighbours.sort).to eq(["2", "3", "4", "5", "6", "7"])
		expect(grid.cells[-2].neighbours.sort).to eq(["1", "2", "3", "4", "5", "6", "7", "8"])
		expect(grid.cells[1].neighbours.sort).to eq(["2", "3", "5", "6", "7", "9"])
	end
 	
 	it "tries to solve by asking each cell to solve" do
 		dupe = zero_grid
 		zero_grid.try_to_solve
 		expect(dupe).to eq(zero_grid)	
 	end

 	it "knows if it is solved" do
		expect(zero_grid.solved?).to be_false
		expect(solved_grid.solved?).to be_true
 	end


end
