class NullMixedNumber
		
	def initialize
		
	end

	def ==(other)
		other == nil
	end

	def nil?
		true
	end

	def to_m
		nil
	end

	def method_missing(name, *args, &block)
		nil
	end

end
