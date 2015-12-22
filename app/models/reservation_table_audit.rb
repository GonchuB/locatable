class ReservationTableAudit < ActiveRecord::Base
  belongs_to :table
  belongs_to :reservation
end
