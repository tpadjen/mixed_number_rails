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

		def load(n)
			self.parse(decode(n))
		end

		def dump(obj)
			return nil if obj.nil?

			unless obj.is_a?(self) || obj.respond_to?(:to_m)
	      raise ::ActiveRecord::SerializationTypeMismatch,
	        "Attribute was supposed to be a #{self}, but was a #{obj.class}. -- #{obj.inspect}"
	    end

	    encode(obj.to_m)
		end

		private

			def encode(mixed)
				f = ("%.32f" % mixed.to_f)[0..32]
				w = mixed.whole.to_s
				n = mixed.fraction.numerator.to_s
				d = mixed.fraction.denominator.to_s
				[f, w, n, d].join(":") + ":--encoded--"
			end

			def decode(n)
				return n if !n

				if n =~ /--encoded--/
					f, w, n, d = *n.split(':')
					"#{w} #{n}/#{d}"
				else
					n.to_m
				end

			end
	end

end
