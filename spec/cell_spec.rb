require_relative "../lib/cell.rb"




describe Cell do 

	def cellulize(array)
		array.map.with_index {|v,i| Cell.new(v, i)}
	end

	let(:cell) {Cell.new("0", 0)}
	let(:another_cell) {Cell.new("6", 1)}

	let(:row) {cellulize(["0","5","0","9","0","4","0","0","0"])}
  let(:column) {cellulize(["2","0","0","0","8","0","0","0","1"])}
  let(:box) {cellulize(["2","0","0","0","5","0","0","3","7"])}

	it "initializees with the value" do 		
		expect(cell.value).to eq("0")
	end

	it "checks if it is filled out (it is not if 0 or nil)" do
		cell.value = "0"
		expect(cell.filled_out?).to be_false
		cell.value = "5"
		expect(cell.filled_out?).to be_true
	end

	it "is able to be aware of candidate values" do
		expect{cell.candidates}.not_to raise_error(Exception)
	end

	it "is be able to be aware of neighbours (cells in same rows, columns and boxes" do
		expect{cell.neighbours}.not_to raise_error(Exception)
	end

	it "is able to add neighbours" do
		cell.add_neighbour(row)
		expect(cell.neighbours_values.sort).to eq(["4","5","9"])
	end

	it "is able to create candidate values" do
		cell.add_neighbour(row)
    cell.add_neighbour(column)
    cell.add_neighbour(box)
		#expect(cell.neighbours).to eq([[row], [column], [box]])
		expect(cell.neighbours_values.sort).to eq(["1","2","3","4","5","7","8","9"])
		expect(cell.candidates).to eq(["6"])
	end

	it "is able to tell if it is solved" do
		expect(cell.solved?).to be_false
		expect(another_cell.solved?).to be_true
	end

	it "is able to solve depending on neighbouring values" do
		expect(cell.solved?).to be_false
		cell.add_neighbour(row)
    cell.add_neighbour(column)
    cell.add_neighbour(box)
		expect(cell.candidates).to eq(["6"])
		expect(cell.candidates.size).to eq(1)
		cell.solve
		expect(cell.value).to eq("6")
		expect(cell.solved?).to be_true
	end

	it "can assume a value" do
		cell.assume("6")
		expect(cell.value).to eq("6")
	end


	
end

