require "mixed_number"
require_relative "null_mixed_number"

class MixedNumber

	class << self
		alias :parse_with_errors :parse

		def parse(input)
			parse_with_errors(input)
		rescue MixedNumber::MixedNumberFormatError
			NullMixedNumber.new
		end

		def load(decimal)
			self.parse(decimal)
		end

		def dump(obj)
			return nil if obj.nil?

			unless obj.is_a?(self) || obj.respond_to?(:to_m)
	      raise ::ActiveRecord::SerializationTypeMismatch,
	        "Attribute was supposed to be a #{self}, but was a #{obj.class}. -- #{obj.inspect}"
	    end

	    obj.to_m.to_d
		end
	end

end
