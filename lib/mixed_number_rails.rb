require "mixed_number"

module MixedNumberRails
end

class MixedNumber

	class << self
		def load(decimal)
			self.parse(decimal)
		end

		def dump(obj)
			unless obj.is_a?(self) || obj.respond_to?(:to_m)
	      raise ::ActiveRecord::SerializationTypeMismatch,
	        "Attribute was supposed to be a #{self}, but was a #{obj.class}. -- #{obj.inspect}"
	    end

	    obj.to_m.to_d
		end
	end

end
