class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"


  validates :rating, presence: true 
  validates :description, presence: true 
  validates :reservation_id, presence: true 
  validate :valid_accepted
  validate :after_checkout


	def valid_accepted
	  	if reservation_id.present? && Reservation.find(reservation_id).status == "pending" 
			errors.add(:reservation_id, "need a valid reservation for a review")
	    end
	end 

	def after_checkout
	  	if reservation_id.present? && Reservation.find(reservation_id).checkout > Time.now.to_date 
			errors.add(:reservation_id, "you have not checked out")
	    end
	end 

end
