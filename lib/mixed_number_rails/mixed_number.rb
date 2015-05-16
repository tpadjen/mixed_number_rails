require "mixed_number"

class MixedNumber

	class << self
		def load(decimal)
			self.parse(decimal)
		rescue MixedNumber::MixedNumberFormatError
			nil
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