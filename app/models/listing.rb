class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validates :address, presence: true 
  validates :listing_type, presence: true 
  validates :title, presence: true 
  validates :description, presence: true 
  validates :neighborhood_id, presence: true 
  validates :price, presence: true 

  def average_review_rating
    rating_sum = 0
    self.reviews.each do |review|
      rating_sum += review.rating 
    end 
    rating_sum.to_f / self.reviews.count
  end 

  after_create do 
    user = User.find(self.host_id)
    user.host = true 
    user.save
  end 

  before_destroy do 
    user = User.find(self.host_id)
    if user.listings.count == 1
      user.host = false
      user.save
    end 
  end 

end
