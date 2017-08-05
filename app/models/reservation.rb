class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review


  validates :checkin, :checkout, :listing_id, :status, presence: true
  validate :checkin_before_checkout
  validate :guest_diff_from_host
  validate :invalid_checkin
  validate :invalid_checkout
  validate :invalid_checkin_checkout





  def checkin_before_checkout
  	if checkin.present? && checkout.present? && checkin >= checkout
		errors.add(:checkin, "can't be after or the same day of checkout")
    end
end 

  def guest_diff_from_host
  	if guest_id.present? && guest_id == Listing.find(listing_id).host_id 
		errors.add(:guest_id, "can't reserve your own property")
    end
end 



def invalid_checkin
    if checkin.present? && listing_id.present? && Listing.find(listing_id).reservations.reject{|reservation| reservation == self}.any? { |reservation| checkin <= reservation.checkout && checkin >= reservation.checkin }
    errors.add(:checkin, "not a valid checkin time")
    end
end 


  def invalid_checkout
  	if checkout.present? && listing_id.present? && Listing.find(listing_id).reservations.reject{|reservation| reservation == self}.any? { |reservation| checkout <= reservation.checkout && checkout >= reservation.checkin }
		errors.add(:checkout, "not a valid checkout time")
    end
end 

  def invalid_checkin_checkout
  	if checkin.present? && checkout.present? && listing_id.present? && Listing.find(listing_id).reservations.reject{|reservation| reservation == self}.any? { |reservation| checkin <= reservation.checkout && checkout >= reservation.checkin } 
		errors.add(:checkin, "not valid dates")
		errors.add(:checkout, "not valid dates")
    end
end 
 

  def duration
  	self.checkout - self.checkin
  end 

  def total_price
  	self.duration * Listing.find(self.listing_id).price
  end 

end
