require_relative "../lib/grid.rb"
require_relative "../lib/cell.rb"

describe Grid do 

let(:puzzle) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
let(:zero_puzzle) {'0'*81}
let(:grid) {Grid.new(puzzle)} 
let(:zero_grid) {Grid.new(zero_puzzle)} 

	it "initializes with a string of 81 values" do
		expect(grid.cells.map{|cell| cell.value}.join).to eq(puzzle) 
	end

	it "should have a method to solve the puzzle" do  
		expect{grid.solve}.not_to raise_error(Exception)
	end

	it "should be able to find no cells' neighbours' values for a zero string" do
		expect(zero_grid.cells.first.neighbours).to eq([])
	end

	it "should be able to find all cells' neighbours' values for a non-zero string" do
		expect(grid.cells.first.neighbours.sort).to eq(["1", "2", "3", "4", "5", "7", "8", "9"])
		expect(grid.cells[3].neighbours.sort).to eq([ "1", "2", "3", "5", "6", "8", "9"])
		expect(grid.cells.last.neighbours.sort).to eq(["2", "3", "4", "5", "6", "7"])
		expect(grid.cells[-2].neighbours.sort).to eq(["1", "2", "3", "4", "5", "6", "7", "8"])
		expect(grid.cells[1].neighbours.sort).to eq(["2", "3", "5", "6", "7", "9"])
	end
 	


end
