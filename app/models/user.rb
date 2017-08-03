class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  
  # as hosts
  
  has_many :guests, :class_name => "User", :through => :reservations, :foreign_key => 'guest_id'

  #as guest

  has_many :hosts, :class_name => "User", :through => :listings, :foreign_key => 'host_id'





  # has_many :guests, through: :trips, source: :guest
  # has_many :hosts, through: :listings, source: :host


  # def host_reviews
  # 	if self.host == true 
  # 		host_listings = Listing.all.where(host_id: self.id)
  # 		review_array = []
  # 		host_listings.each do |listing|
  # 			review_array << listing.reviews   		
  # 		end
  # 		review_array.flatten 
  # 	end
  # end 

  # def guests
  # 	if self.host == true 
  # 		host_listings = Listing.all.where(host_id: self.id)
  # 		binding.pry
  # 		review_array = []
  # 		host_listings.each do |listing|
  # 			review_array << listing.reviews   		

  # 		end
  # 		review_array.flatten 
  # 	end
  # end  



  
end
