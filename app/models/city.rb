class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start_date_input, end_date_input)		
		self.listings.reject do |listing|
			# reject if any of the reservations overlap
			listing.reservations.any? { |reservation| Date.parse(start_date_input) <= reservation.checkout && Date.parse(end_date_input) >= reservation.checkin }
		end 
  end 

  def self.highest_ratio_res_to_listings
  	max_ratio = 0
  	max_city = []
  	City.all.each do |city|
  		if city.res_count.to_f / city.listings.count > max_ratio
  			max_ratio = city.res_count.to_f / city.listings.count
  			max_city << city 
  		end 
  	end
  	max_city.last
  end 

  def res_count
  	res_count = 0 
  	self.listings.each do |listing|
  		res_count += listing.reservations.count 
  	end 
  	res_count
  end 


  	def self.most_res
  		max_res = 0
  		max_city = []
  		City.all.each do |city|
	  			if city.res_count > max_res 
	  				max_res = city.res_count 
	  				max_city << city 
	  			end 
  		end 
  		max_city.last
  	end 

   



# Listing.where("? BETWEEN #{start_date} AND #{end_date}", :created_at)
# startdate, start_date}...#{end_date}")


end

