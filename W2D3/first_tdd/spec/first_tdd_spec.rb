require 'first_tdd'

describe "#my_uniq" do
  let(:ary) { [1,2,3,1,1,2] }

  it "removes duplicates" do
    expect(ary.my_uniq).to eq([1,2,3])
  end
end

describe "#two_sum" do
  let(:ary) { [-1,0,2,-2,1] }

  it "finds the pairs" do
    expect(ary.two_sum).to eq([[0,4],[2,3]])
  end

end

describe "#my_transpose" do
  let(:matrix) { [[0,1,2],[3,4,5],[6,7,8]] }

  it "transposes the matrix" do
    expect(matrix.my_transpose).to eq(matrix.transpose)
  end

end

describe "#stock_picker" do

  it "gives the most profitable days" do
    expect(stock_picker([1,2,3,4])).to eq([0,3])
    expect(stock_picker([4,3,1,2])).to eq([2,3])
    expect(stock_picker([4,1,3,2])).to eq([1,2])
  end

  it "returns nil if no days are profitable" do
    expect(stock_picker([4,3,2,1])).to be_nil
  end

end
