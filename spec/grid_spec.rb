require_relative "../lib/grid.rb"
require_relative "../lib/cell.rb"

describe Grid do 

let(:puzzle) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
let(:grid) {Grid.new(puzzle)} 
let(:solved_grid) {Grid.new('615493872348127956279568431496832517521746389783915264952681743864379125137254698')}

let(:zero_puzzle) {'0'*81}
let(:zero_grid) {Grid.new(zero_puzzle)} 

let(:hard_puzzle) {"800000000003600000070090200050007000000045700000100030001000068008500010090000400"}
let(:hard_grid) {Grid.new(hard_puzzle)} 

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

 	it "can inspect itself" do 
		expect(solved_grid.inspect).to eq("[[6, 1, 5], [4, 9, 3], [8, 7, 2]]\n[[3, 4, 8], [1, 2, 7], [9, 5, 6]]\n[[2, 7, 9], [5, 6, 8], [4, 3, 1]]\n\n[[4, 9, 6], [8, 3, 2], [5, 1, 7]]\n[[5, 2, 1], [7, 4, 6], [3, 8, 9]]\n[[7, 8, 3], [9, 1, 5], [2, 6, 4]]\n\n[[9, 5, 2], [6, 8, 1], [7, 4, 3]]\n[[8, 6, 4], [3, 7, 9], [1, 2, 5]]\n[[1, 3, 7], [2, 5, 4], [6, 9, 8]]\n\n")
 	end

 	it "can replicate itself" do
 		new_grid = grid.replicate
 		expect(new_grid).not_to eq(grid)
 		expect(new_grid.inspect).to eq(grid.inspect)  
 	end

  context "solving sudoku" do
    it "can solve an easy puzzle" do
      expect(grid.solved?).to be_false
      grid.solve
      expect(grid.solved?).to be_true
      expect(grid.to_s).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
    end

		it "can solve another easy puzzle" do
			easy_grid = Grid.new('078090063009308450006502010902007000034010708000600395065049100200080070410203906')
			expect(easy_grid.solved?).to be_false
      easy_grid.solve
      expect(easy_grid.solved?).to be_true
      expect(easy_grid.to_s).to eq('578491263129368457346572819952837641634915728781624395865749132293186574417253986')
    end

	context "solving non-easy sudoku" do
    it "can steal a solution" do
    	zero_grid.steal_solution(solved_grid) 
    	expect(zero_grid).not_to eq(solved_grid)
 			expect(zero_grid.inspect).to eq(solved_grid.inspect)  
    end

    it "can solve a hard sudoku" do 
    	expect(hard_grid.solved?).to be_false
      hard_grid.solve
      expect(hard_grid.solved?).to be_true 
      expect(hard_grid.to_s).to eq('')
    end
  end

  end

end
