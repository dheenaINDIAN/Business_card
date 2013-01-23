class BusinessController < ApplicationController

 def card
    if params[:name] 
	card = Business.new(:name => params[:name], :mobile => params[:mobile], :personal_mail => params[:personal_mail], :company_mail => params[:company_mail], :skype  => params[:skype] , :company_name => params[:company_name], :designation  => params[:designation], :street_work  => params[:street_work], :street_home  => params[:street_home], :city  => params[:city], :pincode  => params[:pincode], :telephone  => params[:telephone], :state  => params[:state], :country  => params[:country])
	  if card.save
	    respond_to do |format|
	    format.json   { render :json => {:card_id => card.id,:message => 'saved successfully'}   }
	    end
	   end
	  else
        respond_to do |format|
	    @card = 'Name field required'
        format.json   { render :json => {:message => @card}   } 
	    end
	end
	
 end

 def vcard
	@user = Business.find_by_id(params[:card_id].to_s)
    p "--------#{@user.inspect}"
	card = Vpim::Vcard::Maker.make2 do |maker|
        
		maker.add_name do |name|
    			name.prefix = ''
    			name.given = @user.name if (@user.name)
    			name.family = @user.street_home if (@user.street_home)
				
		end
        
		maker.add_field(Vpim::DirectoryInfo::Field.create('ORG', @user.company_name)) if (@user.company_name)
		maker.add_field(Vpim::DirectoryInfo::Field.create('TITLE', @user.designation)) if (@user.designation)
		
        maker.add_tel(@user.mobile) { |e| e.location = 'cell' } if (@user.mobile)
		maker.add_tel(@user.telephone) { |e| e.location = 'home' } if (@user.telephone)
		
		maker.add_email(@user.company_mail) { |e| e.location = 'work' } if (@user.company_mail)
		maker.add_email(@user.personal_mail) { |e| e.location = 'home' } if (@user.personal_mail)
		#maker.add_email(@user.skype) { |e| e.location = 'skype' } if (@user.skype)
		
				
		maker.add_addr do |addr|
    			#addr.preferred = true
    			#addr.location = 'work'
    			addr.street = @user.street_work if (@user.street_work)
    			addr.locality = @user.city if (@user.city)
    			addr.region = @user.state if (@user.state)
				addr.country = @user.country if (@user.country )
				addr.postalcode = @user.pincode if (@user.pincode)
		end

		
		#maker.add_field("skype"){ |e| e.location = 'work' }
		 
		

	end

	send_data card.to_s, :filename => "contact.vcf"
  end
  
  def ruban
  
       respond_to do |format|
	    @card =  [{:summary=> "Vandalur is a census town in Kancheepuram district in the Indian state of Tamil Nadu. The Arignar Anna Zoological Park, located here houses some rare species of wild flora and fauna and is famous throughout India.  ",:title => "sybrant mobile team",:rank=> 95,:distance=> "1.4988",:elevation=> 33,:wikipediaUrl=> "en.wikipedia.org/wiki/Vandalur",:countryCode => "IN",:feature => "city",:lng => 80.0808,:lang => "en",:lat => 12.8928}]
        format.json   { render :json => {:geonames => @card}   } 
	   end	
  end
end
