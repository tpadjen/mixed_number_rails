
describe 'Mixed Number Rails' do
  
	context 'Serialization : ' do

	  context 'loading : ' do
	  	it 'has a load method' do
	  	  expect(MixedNumber).to respond_to(:load)
	  	end

	  	it 'returns a MixedNumber' do
	  	  expect(MixedNumber.load(BigDecimal(1.5, 3))).to be_a(MixedNumber)
	  	end

	  	it 'loads the data correctly' do
	  	  expect(MixedNumber.load(BigDecimal(1.5, 3))).to eq(1.5)
	  	end
	  end

	  context 'dumping : ' do
	  	it 'has a dump method' do
	  	  expect(MixedNumber).to respond_to(:dump)
	  	end

	  	it 'only accepts a MixedNumber-like object' do
	  	  expect{MixedNumber.dump(Object.new)}.to raise_error(ActiveRecord::SerializationTypeMismatch)
	  	  expect{MixedNumber.dump(MixedNumber())}.not_to raise_error()
	  	  expect{MixedNumber.dump("1 1/2")}.not_to raise_error()
	  	end

	  	it 'dumps the data correctly' do
	  	  expect(MixedNumber.dump(MixedNumber(1.5))).to be_a(BigDecimal)
	  	  expect(MixedNumber.dump(MixedNumber(1.5))).to eq(1.5)
	  	end
	  end

	  context 'Items' do
	  	
	  	context 'building' do
	  	  before(:each) do
	  	  	@item = Item.build(amount: "1 1/2")
	  	  end

	  	  # it 'amount is a mixed number' do
	  	  # 	expect(@item.amount).to be_a(MixedNumber)
	  	  # end
	  	end

	  	context 'creation' do
	  	  before(:each) do
	  	  	@item = Item.create(amount: "1 1/2")
	  	  end

	  	  it 'amount is a mixed number' do
	  	  	expect(@item.amount).to be_a(MixedNumber)
	  	  end

	  	  it 'amount is a mixed number when retrieved' do
	  	    expect(Item.find(@item.id).amount).to be_a(MixedNumber)
	  	  end
	  	end
	    
	  end

	end

end