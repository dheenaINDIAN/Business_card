class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
	  
	  t.string :name
	  t.string :mobile
	  t.string :personal_mail
	  t.string :company_mail
	  t.string :skype
	  t.string :company_name
	  t.string :designation
	  t.string :street_work
	  t.string :street_home
	  t.string :city
	  t.string :pincode
	  t.string :telephone
	  t.string :state
	  t.string :country

      t.timestamps
    end
  end
end
