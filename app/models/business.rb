class Business < ActiveRecord::Base
   attr_accessible :name, :mobile, :personal_mail, :company_mail, :skype, :company_name, :designation, :street_work, :street_home, :city, :pincode, :telephone, :state, :country
end
