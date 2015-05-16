module MixedNumberRails
	module MixedNumberAttribute
		extend ActiveSupport::Concern

		module ClassMethods
			def mixed_number_attribute(attribute)
				serialize attribute, MixedNumber

				validate -> {
					if read_attribute(attribute).is_a?(NullMixedNumber)
						errors.add(attribute, "is not a valid mixed number")
					end
				}

				define_method(attribute.to_s + '=') do |value|
					if value == nil
						write_attribute(attribute, value)
					else
						write_attribute(attribute, MixedNumber(value))
					end
				end
			end
		end
	end
end

ActiveRecord::Base.send :include, MixedNumberRails::MixedNumberAttribute