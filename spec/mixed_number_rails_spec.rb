
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
	  	  	@item = Item.new(amount: "1 1/2")
	  	  end

	  	  it 'amount is a mixed number' do
	  	  	expect(@item.amount).to be_a(MixedNumber)
	  	  end
	  	end

	  	context 'creation' do
	  	  it 'amount is not set without a default' do
	  	  	item = Item.create()
	  	  	expect(item.amount).to eq(nil)
	  	  end

	  	  it 'amount is a mixed number' do
	  	  	item = Item.create(amount: 0)
	  	  	expect(item.amount).to be_a(MixedNumber)
	  	  end

	  	  it 'amount is a mixed number when retrieved' do
	  	  	item = Item.create(amount: 0)
	  	    expect(Item.find(item.id).amount).to be_a(MixedNumber)
	  	  end
	  	end

	  	context 'invalid mixed numbers' do
	  	  [nil, "", "1 1221", "word", "a/b", "1 2/", "1 + 2"].each do |n|
	  	  	it { expect(Item.new(   amount: n).amount).to eq(nil) }
	  	  	it { expect(Item.create(amount: n).amount).to eq(nil) }
	  	  end

	  	  it 'invalidates the model' do
	  	    item = Item.create(amount: "1 1221")
	  	    expect(item.valid?).to be(false)
	  	  end

	  	  it 'has an error' do
	  	  	item = Item.create(amount: "1 1221")
	  	    expect(item.errors[:amount]).to include("is not a valid mixed number")
	  	  end


	  	end

	  	# TODO - test sort
	    
	  end

	end

end