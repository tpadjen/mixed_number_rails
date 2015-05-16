class Item < ActiveRecord::Base
	serialize :amount, MixedNumber
end
