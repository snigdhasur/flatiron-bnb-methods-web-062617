class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  
  # as hosts
  has_many :guests, :class_name => "User", :through => :reservations, :foreign_key => 'guest_id'
  has_many :host_reviews, :class_name => "Review", :source => :listing, :foreign_key => 'reservation_id'



  # #as guest
  has_many :hosts, :class_name => "User", :through => :trips, :foreign_key => 'host_id', source: 'listing'


  
end
