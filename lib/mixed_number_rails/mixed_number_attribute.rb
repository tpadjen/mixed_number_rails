module MixedNumberRails
	module MixedNumberAttribute
		extend ActiveSupport::Concern

		module ClassMethods
			def mixed_number_attribute(attribute)
				serialize attribute, MixedNumber

				define_method(attribute.to_s + '=') do |value|
					write_attribute(attribute, MixedNumber(value))
				end
			end
		end
	end
end

ActiveRecord::Base.send :include, MixedNumberRails::MixedNumberAttribute