module MixedNumberRails
	module MixedNumberAttribute
		extend ActiveSupport::Concern

		module ClassMethods
			def mixed_number_attribute(attribute)
				serialize attribute, MixedNumber
			end
		end
	end
end

ActiveRecord::Base.send :include, MixedNumberRails::MixedNumberAttribute