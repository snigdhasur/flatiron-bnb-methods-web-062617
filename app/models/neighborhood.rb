class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def self.most_res
		max_res = 0
  		max_neighborhood = []
  		self.all.each do |neighborhood|
	  			if neighborhood.res_count > max_res 
	  				max_res = neighborhood.res_count 
	  				max_neighborhood << neighborhood 
	  			end 
  		end 
  		max_neighborhood.last
  end 



  def res_count
  	res_count = 0 
  	self.listings.each do |listing|
  		res_count += listing.reservations.count 
  	end 
  	res_count
  end 

   def self.highest_ratio_res_to_listings
  	max_ratio = 0
  	max_neighborhood = []
  	self.all.each do |neighborhood|
  		if neighborhood.res_count.to_f / neighborhood.listings.count > max_ratio
  			max_ratio = neighborhood.res_count.to_f / neighborhood.listings.count
  			max_neighborhood << neighborhood 
  		end 
  	end
  	max_neighborhood.last
  end 


  def neighborhood_openings(start_date, end_date)		
		self.listings.reject do |listing|
			# reject if any of the reservations overlap
			listing.reservations.any? { |reservation| Date.parse(start_date) <= reservation.checkout && Date.parse(end_date) >= reservation.checkin }
		end 
  end 

end
