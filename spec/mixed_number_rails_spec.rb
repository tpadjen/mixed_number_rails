
describe 'Mixed Number Rails' do
  
	context 'Serialization : ' do

	  context 'loading : ' do
	  	it 'has a load method' do
	  	  expect(MixedNumber).to respond_to(:load)
	  	end

	  	it 'returns a MixedNumber' do
	  		code = "33.333333333333333333333333333333:33:1:5:--encoded--"
	  	  expect(MixedNumber.load(code)).to be_a(MixedNumber)
	  	end

	  	it 'loads the data correctly' do
	  		code = "33.333333333333333333333333333333:33:1:5:--encoded--"
	  	  expect(MixedNumber.load(code)).to eq(33.2)
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
	  	  expect(MixedNumber.dump(MixedNumber(1.5))).to be_a(String)
	  	  expect(MixedNumber.dump(MixedNumber(1.5))).to eq("1.5000000000000000000000000000000:1:1:2:--encoded--")
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
	  	  	
	  	  	let(:item) { Item.create(amount: n) }

	  	  	it 'does not set the initial value' do
	  	  		expect(Item.new(amount: n).amount).to eq(nil)
	  	  	end

	  	  	it 'does not set the value on save' do
	  	  		expect(item.amount).to eq(nil)
	  	  	end

	  	  	it 'is not valid' do
	  	  		expect(item.valid?).to be(false)
	  	  	end

	  	  	it 'has an error message' do
	  	  	  expect(item.errors[:amount]).to include("is not a valid mixed number")
	  	  	end

	  	  end

	  	end

	  	context 'Sorting' do
	  		before(:each) { Item.destroy_all }
	  	  
	  		it 'can sort a database mixed number' do
	  		  a = Item.create(amount: " 2 1/2")
	  		  b = Item.create(amount: "-3 3/4")
	  		  c = Item.create(amount: " 1 1/2")

	  		  expect(Item.all.order(:amount)).to eq([b, c, a])
	  		end

	  	end
	    
	  end

	end

end