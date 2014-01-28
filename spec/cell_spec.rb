require_relative "../lib/cell.rb"

describe Cell do 

	let(:cell) {Cell.new("0", 0)}

	it "should initialize with the value" do 
		
		expect(cell.value).to eq("0")
	end

	it "should check if it is filled out (it is not if 0 or nil)" do
		cell.value = "0"
		expect(cell.filled_out?).to be_false
		cell.value = "5"
		expect(cell.filled_out?).to be_true
	end

	it "should be able to be aware of candidate values" do
		expect{cell.candidates}.not_to raise_error(Exception)
	end

	it "should be able to be aware of neighbours (cells in same rows, columns and boxes" do
		expect{cell.neighbours}.not_to raise_error(Exception)
	end

	it "should be able to add a neighbour cell" do
		another_cell = Cell.new("6", 1)
		cell.add_neighbour(another_cell.value)
		expect(cell.neighbours).to eq([another_cell.value])
	end
	
end

